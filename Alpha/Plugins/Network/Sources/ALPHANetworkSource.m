//
//  ALPHANetworkSource.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

//
// PonyDebugger
// Copyright 2012 Square Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

@import ObjectiveC.runtime;
@import ObjectiveC.message;

#import "ALPHANetworkSource.h"
#import "ALPHARequestState.h"

#import "ALPHANetworkModel.h"

NSString *const ALPHANetworkDataIdentifier = @"com.unifiedsense.alpha.data.network";

@interface __NSCFURLSessionConnection_Swizzles : NSObject

@property(copy) NSURLSessionTask *task;

@end

@implementation __NSCFURLSessionConnection_Swizzles

@dynamic task;

- (void)alpha__redirectRequest:(NSURLRequest *)arg1 redirectResponse:(NSURLResponse *)arg2 completion:(id)arg3;
{
    [[ALPHANetworkSource sharedSource] URLSession:[self.task valueForKey:@"session"] task:self.task willPerformHTTPRedirection:(id)arg2 newRequest:arg1];
    
    [self alpha__redirectRequest:arg1 redirectResponse:arg2 completion:arg3];
}

- (void)alpha__didReceiveData:(id)arg1;
{
    [[ALPHANetworkSource sharedSource] URLSession:[self.task valueForKey:@"session"] dataTask:(id)self.task didReceiveData:arg1];
    
    [self alpha__didReceiveData:arg1];
}

- (void)alpha__didReceiveResponse:(NSURLResponse *)response sniff:(BOOL)sniff;
{
    // This can be called multiple times for the same request. Make sure it doesn't
    [[ALPHANetworkSource sharedSource] URLSession:[self.task valueForKey:@"session"] dataTask:(id)self.task didReceiveResponse:response];
    
    [self alpha__didReceiveResponse:response sniff:sniff];
}

- (void)alpha__didFinishWithError:(NSError *)arg1;
{
    [[ALPHANetworkSource sharedSource] URLSession:[self.task valueForKey:@"session"] task:self.task didCompleteWithError:arg1];
    [self alpha__didFinishWithError:arg1];
}

@end


@interface ALPHANetworkSource ()

/*!
 *  Holds model objects
 */
@property (nonatomic, strong) NSMutableDictionary *baseRequests;

@property (nonatomic, strong) NSCache *responseCache;
@property (nonatomic, strong) NSMutableDictionary *connectionStates;
@property (nonatomic) dispatch_queue_t queue;

@end

@implementation ALPHANetworkSource

+ (instancetype)sharedSource
{
    static id sharedCollector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCollector = [[[self class] alloc] init];
    });
    return sharedCollector;
}

/*!
 *  Creates unique request ID as a string
 *
 *  @return unique request ID
 */
+ (NSString *)nextRequestID;
{
    static NSInteger sequenceNumber = 0;
    static NSString *seed = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CFUUIDRef uuid = CFUUIDCreate(CFAllocatorGetDefault());
        seed = (__bridge NSString *)CFUUIDCreateString(CFAllocatorGetDefault(), uuid);
        CFRelease(uuid);
    });
    
    return [[NSString alloc] initWithFormat:@"%@-%ld", seed, (long)(++sequenceNumber)];
}

#pragma mark Delegate Injection Convenience Methods

+ (SEL)swizzledSelectorForSelector:(SEL)selector;
{
    return NSSelectorFromString([NSString stringWithFormat:@"_alpha_swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}

/// All swizzled delegate methods should make use of this guard.
/// This will prevent duplicated sniffing when the original implementation calls up to a superclass implementation which we've also swizzled.
/// The superclass implementation (and implementations in classes above that) will be executed without inteference if called from the original implementation.
+ (void)sniffWithoutDuplicationForObject:(NSObject *)object selector:(SEL)selector sniffingBlock:(void (^)(void))sniffingBlock originalImplementationBlock:(void (^)(void))originalImplementationBlock
{
    const void *key = selector;
    
    // Don't run the sniffing block if we're inside a nested call
    if (!objc_getAssociatedObject(object, key)) {
        sniffingBlock();
    }
    
    // Mark that we're calling through to the original so we can detect nested calls
    objc_setAssociatedObject(object, key, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    originalImplementationBlock();
    objc_setAssociatedObject(object, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)instanceRespondsButDoesNotImplementSelector:(SEL)selector class:(Class)cls;
{
    if ([cls instancesRespondToSelector:selector]) {
        unsigned int numMethods = 0;
        Method *methods = class_copyMethodList(cls, &numMethods);
        
        BOOL implementsSelector = NO;
        for (int index = 0; index < numMethods; index++) {
            SEL methodSelector = method_getName(methods[index]);
            if (selector == methodSelector) {
                implementsSelector = YES;
                break;
            }
        }
        
        free(methods);
        
        if (!implementsSelector) {
            return YES;
        }
    }
    
    return NO;
}

+ (void)replaceImplementationOfSelector:(SEL)selector withSelector:(SEL)swizzledSelector forClass:(Class)cls withMethodDescription:(struct objc_method_description)methodDescription implementationBlock:(id)implementationBlock undefinedBlock:(id)undefinedBlock;
{
    if ([self instanceRespondsButDoesNotImplementSelector:selector class:cls]) {
        return;
    }
    
#ifdef __IPHONE_6_0
    IMP implementation = imp_implementationWithBlock((id)([cls instancesRespondToSelector:selector] ? implementationBlock : undefinedBlock));
#else
    IMP implementation = imp_implementationWithBlock((__bridge void *)([cls instancesRespondToSelector:selector] ? implementationBlock : undefinedBlock));
#endif
    
    Method oldMethod = class_getInstanceMethod(cls, selector);
    if (oldMethod) {
        class_addMethod(cls, swizzledSelector, implementation, methodDescription.types);
        
        Method newMethod = class_getInstanceMethod(cls, swizzledSelector);
        
        method_exchangeImplementations(oldMethod, newMethod);
    } else {
        class_addMethod(cls, selector, implementation, methodDescription.types);
    }
}

#pragma mark - Delegate Injection

+ (void)swizzleNSURLSessionClasses;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _swizzleNSURLSessionClasses];
    });
}

+ (void)_swizzleNSURLSessionClasses;
{
    Class cfURLSessionConnectionClass = NSClassFromString(@"__NSCFURLSessionConnection");
    if (!cfURLSessionConnectionClass) {
        NSLog(@"Could not find __NSCFURLSessionConnection");
        return;
    }
    
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList([__NSCFURLSessionConnection_Swizzles class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Method m = methods[i];
        SEL sourceMethod = method_getName(m);
        const char *encoding = method_getTypeEncoding(m);
        NSString *sourceMethodName = NSStringFromSelector(sourceMethod);
        NSAssert([sourceMethodName hasPrefix:@"alpha_"], @"Expecting swizzle methods only");
        NSString *originalMethodName = [sourceMethodName substringFromIndex:6];
        SEL originalMethod = NSSelectorFromString(originalMethodName);
        NSAssert(originalMethod, @"Must find selector");
        
        IMP sourceImp = method_getImplementation(m);
        
        IMP originalImp = class_getMethodImplementation(cfURLSessionConnectionClass, originalMethod);
        
        NSAssert(originalImp, @"Must find imp");
        
        //NSLog(@"SWIZZLING: %@ with %@", sourceMethodName, originalMethodName);
        
        BOOL success = class_addMethod(cfURLSessionConnectionClass, sourceMethod, originalImp, encoding);
        
        NSAssert(success, @"Should be successful");
        class_replaceMethod(cfURLSessionConnectionClass, originalMethod, sourceImp, encoding);

        if (!success)
        {
            NSLog(@"Alpha: Failed to swizzle - %@", sourceMethodName);
        }
        
        // TODO: Check if replaced imp in case of redirectRequest.
        //IMP replacedImp = class_replaceMethod(cfURLSessionConnectionClass, originalMethod, sourceImp, encoding);
        //NSAssert(replacedImp, @"Expected original method to have been replaced");
    }
    
    if (methods) {
        free(methods);
    }
}

+ (void)injectIntoAllNSURLConnectionDelegateClasses;
{
    // Only allow swizzling once.
    static BOOL swizzled = NO;
    if (swizzled) {
        return;
    }
    
    swizzled = YES;
    
    // Swizzle any classes that implement one of these selectors.
    const SEL selectors[] = {
        @selector(connectionDidFinishLoading:),
        @selector(connection:didReceiveResponse:),
        @selector(URLSession:dataTask:didReceiveResponse:completionHandler:),
        @selector(URLSession:task:didCompleteWithError:),
        @selector(URLSession:downloadTask:didFinishDownloadingToURL:)
    };
    
    const int numSelectors = sizeof(selectors) / sizeof(SEL);
    
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (NSInteger classIndex = 0; classIndex < numClasses; ++classIndex) {
            Class class = classes[classIndex];
            
            if (class_getClassMethod(class, @selector(isSubclassOfClass:)) == NULL) {
                continue;
            }
            
            if (![class isSubclassOfClass:[NSObject class]]) {
                continue;
            }
            
            if ([class isSubclassOfClass:[self class]]) {
                continue;
            }
            
            for (int selectorIndex = 0; selectorIndex < numSelectors; ++selectorIndex) {
                if ([class instancesRespondToSelector:selectors[selectorIndex]]) {
                    [self injectIntoDelegateClass:class];
                    break;
                }
            }
        }
        
        free(classes);
    }
}

+ (void)injectIntoDelegateClass:(Class)cls;
{
    // Connections
    [self injectWillSendRequestIntoDelegateClass:cls];
    [self injectDidReceiveDataIntoDelegateClass:cls];
    [self injectDidReceiveResponseIntoDelegateClass:cls];
    [self injectDidFinishLoadingIntoDelegateClass:cls];
    [self injectDidFailWithErrorIntoDelegateClass:cls];
}

+ (void)injectWillSendRequestIntoDelegateClass:(Class)cls;
{
    SEL selector = @selector(connection:willSendRequest:redirectResponse:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    Protocol *protocol = @protocol(NSURLConnectionDataDelegate);
    if (!protocol) {
        protocol = @protocol(NSURLConnectionDelegate);
    }
    
    struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, NO, YES);
    
    typedef NSURLRequest *(^NSURLConnectionWillSendRequestBlock)(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSURLRequest *request, NSURLResponse *response);
    
    NSURLConnectionWillSendRequestBlock undefinedBlock = ^NSURLRequest *(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSURLRequest *request, NSURLResponse *response) {
        [[ALPHANetworkSource sharedSource] connection:connection willSendRequest:request redirectResponse:response];
        return request;
    };
    
    NSURLConnectionWillSendRequestBlock implementationBlock = ^NSURLRequest *(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSURLRequest *request, NSURLResponse *response) {
        __block NSURLRequest *returnValue = nil;
        [self sniffWithoutDuplicationForObject:connection selector:selector sniffingBlock:^{
            undefinedBlock(slf, connection, request, response);
        } originalImplementationBlock:^{
            returnValue = ((id(*)(id, SEL, id, id, id))objc_msgSend)(slf, swizzledSelector, connection, request, response);
        }];
        return returnValue;
    };
    
    [self replaceImplementationOfSelector:selector withSelector:swizzledSelector forClass:cls withMethodDescription:methodDescription implementationBlock:implementationBlock undefinedBlock:undefinedBlock];
}

+ (void)injectDidReceiveResponseIntoDelegateClass:(Class)cls;
{
    SEL selector = @selector(connection:didReceiveResponse:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    Protocol *protocol = @protocol(NSURLConnectionDataDelegate);
    if (!protocol) {
        protocol = @protocol(NSURLConnectionDelegate);
    }
    
    struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, NO, YES);
    
    typedef void (^NSURLConnectionDidReceiveResponseBlock)(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSURLResponse *response);
    
    NSURLConnectionDidReceiveResponseBlock undefinedBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSURLResponse *response) {
        [[ALPHANetworkSource sharedSource] connection:connection didReceiveResponse:response];
    };
    
    NSURLConnectionDidReceiveResponseBlock implementationBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSURLResponse *response) {
        [self sniffWithoutDuplicationForObject:connection selector:selector sniffingBlock:^{
            undefinedBlock(slf, connection, response);
        } originalImplementationBlock:^{
            ((void(*)(id, SEL, id, id))objc_msgSend)(slf, swizzledSelector, connection, response);
        }];
    };
    
    [self replaceImplementationOfSelector:selector withSelector:swizzledSelector forClass:cls withMethodDescription:methodDescription implementationBlock:implementationBlock undefinedBlock:undefinedBlock];
}

+ (void)injectDidReceiveDataIntoDelegateClass:(Class)cls;
{
    SEL selector = @selector(connection:didReceiveData:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    Protocol *protocol = @protocol(NSURLConnectionDataDelegate);
    if (!protocol) {
        protocol = @protocol(NSURLConnectionDelegate);
    }
    
    struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, NO, YES);
    
    typedef void (^NSURLConnectionDidReceiveDataBlock)(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSData *data);
    
    NSURLConnectionDidReceiveDataBlock undefinedBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSData *data) {
        [[ALPHANetworkSource sharedSource] connection:connection didReceiveData:data];
    };
    
    NSURLConnectionDidReceiveDataBlock implementationBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSData *data) {
        [self sniffWithoutDuplicationForObject:connection selector:selector sniffingBlock:^{
            undefinedBlock(slf, connection, data);
        } originalImplementationBlock:^{
            ((void(*)(id, SEL, id, id))objc_msgSend)(slf, swizzledSelector, connection, data);
        }];
    };
    
    [self replaceImplementationOfSelector:selector withSelector:swizzledSelector forClass:cls withMethodDescription:methodDescription implementationBlock:implementationBlock undefinedBlock:undefinedBlock];
}

+ (void)injectDidFinishLoadingIntoDelegateClass:(Class)cls;
{
    SEL selector = @selector(connectionDidFinishLoading:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    Protocol *protocol = @protocol(NSURLConnectionDataDelegate);
    if (!protocol) {
        protocol = @protocol(NSURLConnectionDelegate);
    }
    
    struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, NO, YES);
    
    typedef void (^NSURLConnectionDidFinishLoadingBlock)(id <NSURLConnectionDelegate> slf, NSURLConnection *connection);
    
    NSURLConnectionDidFinishLoadingBlock undefinedBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection) {
        [[ALPHANetworkSource sharedSource] connectionDidFinishLoading:connection];
    };
    
    NSURLConnectionDidFinishLoadingBlock implementationBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection) {
        [self sniffWithoutDuplicationForObject:connection selector:selector sniffingBlock:^{
            undefinedBlock(slf, connection);
        } originalImplementationBlock:^{
            ((void(*)(id, SEL, id))objc_msgSend)(slf, swizzledSelector, connection);
        }];
    };
    
    [self replaceImplementationOfSelector:selector withSelector:swizzledSelector forClass:cls withMethodDescription:methodDescription implementationBlock:implementationBlock undefinedBlock:undefinedBlock];
}

+ (void)injectDidFailWithErrorIntoDelegateClass:(Class)cls;
{
    SEL selector = @selector(connection:didFailWithError:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    Protocol *protocol = @protocol(NSURLConnectionDelegate);
    struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, NO, YES);
    
    typedef void (^NSURLConnectionDidFailWithErrorBlock)(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSError *error);
    
    NSURLConnectionDidFailWithErrorBlock undefinedBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSError *error) {
        [[ALPHANetworkSource sharedSource] connection:connection didFailWithError:error];
    };
    
    NSURLConnectionDidFailWithErrorBlock implementationBlock = ^(id <NSURLConnectionDelegate> slf, NSURLConnection *connection, NSError *error) {
        [self sniffWithoutDuplicationForObject:connection selector:selector sniffingBlock:^{
            undefinedBlock(slf, connection, error);
        } originalImplementationBlock:^{
            ((void(*)(id, SEL, id, id))objc_msgSend)(slf, swizzledSelector, connection, error);
        }];
    };
    
    [self replaceImplementationOfSelector:selector withSelector:swizzledSelector forClass:cls withMethodDescription:methodDescription implementationBlock:implementationBlock undefinedBlock:undefinedBlock];
}

#pragma mark - Getters and Setters

- (NSArray *)requests
{
    NSArray *requests = [self.baseRequests allValues];
    
    requests = [requests sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
                {
                    NSDate* timing1 = [obj1 timing].connectionStartDate;
                    NSDate* timing2 = [obj2 timing].connectionStartDate;
                    
                    if (timing1 && timing2)
                    {
                        return [timing1 compare:timing2];
                    }
                    
                    return NSOrderedSame;
                }];
    
    return [self.baseRequests allValues];
}

- (NSMutableDictionary *)connectionStates
{
    if (!_connectionStates)
    {
        _connectionStates = [NSMutableDictionary dictionary];
    }
    
    return _connectionStates;
}

- (NSMutableDictionary *)baseRequests
{
    if (!_baseRequests)
    {
        _baseRequests = [NSMutableDictionary dictionary];
    }
    
    return _baseRequests;
}

- (NSCache *)responseCache
{
    if (!_responseCache)
    {
        _responseCache = [[NSCache alloc] init];
    }
    
    return _responseCache;
}

- (dispatch_queue_t)queue
{
    if (!_queue)
    {
        _queue = dispatch_queue_create("com.unifiedsense.alpha.data.network.ALPHANetworkSource", DISPATCH_QUEUE_SERIAL);
    }
    
    return _queue;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [[self class] injectIntoAllNSURLConnectionDelegateClasses];
        [[self class] swizzleNSURLSessionClasses];
        
        [self addDataIdentifier:ALPHANetworkDataIdentifier];
    }
    
    return self;
}

#pragma mark - Private Methods

- (void)setResponse:(NSData *)responseBody forRequestID:(NSString *)requestID response:(NSURLResponse *)response request:(NSURLRequest *)request;
{
    //id<PDPrettyStringPrinting> prettyStringPrinter = [PDNetworkDomainController prettyStringPrinterForResponse:response withRequest:request];
    
    NSString *encodedBody = @"";
    BOOL isBinary = NO;
    /*if (!prettyStringPrinter) {
        encodedBody = [responseBody base64EncodedStringWithOptions:0];

        isBinary = YES;
    } else {
        encodedBody = [prettyStringPrinter prettyStringForData:responseBody forResponse:response request:request];
        isBinary = NO;
    }*/
    
    NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  encodedBody, @"body",
                                  [NSNumber numberWithBool:isBinary], @"base64Encoded",
                                  nil];
    
    [self.responseCache setObject:responseDict forKey:requestID cost:[responseBody length]];
}

- (void)performBlock:(dispatch_block_t)block;
{
    dispatch_async(self.queue, block);
}

#pragma mark - ALPHADataCollector

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    ALPHANetworkModel *model = [[ALPHANetworkModel alloc] initWithIdentifier:ALPHANetworkDataIdentifier];
    model.requests = self.requests;
    
    return model;
}

#pragma mark - Data Model Helpers

- (ALPHANetworkConnection *)networkConnectionForObject:(id)object
{
    ALPHANetworkConnection *networkConnection = nil;
    
    if ([object isKindOfClass:[NSURLSessionTask class]])
    {
        networkConnection = [self _networkConnectionForTask:object];
    }
    else if ([object isKindOfClass:[NSURLConnection class]])
    {
        networkConnection = [self _networkConnectionForConnection:object];
    }
    
    if (!networkConnection.timing)
    {
        networkConnection.timing = [[ALPHANetworkConnectionTiming alloc] init];
    }
    
    return networkConnection;
}

/*!
 *  Creates and returns network connection object, do NOT call directly,
 *  call networkConnectionForObject instead.
 *
 *  @param connection Connection that was sent
 *
 *  @return network connection object
 */
- (ALPHANetworkConnection *)_networkConnectionForConnection:(NSURLConnection *)connection
{
    NSString *requestID = [self requestIDForConnection:connection];
    
    if (!self.baseRequests[requestID])
    {
        ALPHANetworkConnection *connection = [[ALPHANetworkConnection alloc] init];
        connection.type = ALPHANetworkConnectionTypeConnection;
        connection.requestID = [requestID copy];
        
        self.baseRequests[requestID] = connection;
    }
    
    return self.baseRequests[requestID];
}

/*!
 *  Creates and returns network connection object, do NOT call directly,
 *  call networkConnectionForObject instead.
 *
 *  @param task URL session task
 *
 *  @return network connection object
 */
- (ALPHANetworkConnection *)_networkConnectionForTask:(NSURLSessionTask *)task
{
    NSString *requestID = [self requestIDForTask:task];
    
    if (!self.baseRequests[requestID])
    {
        ALPHANetworkConnection *connection = [[ALPHANetworkConnection alloc] init];
        connection.type = ALPHANetworkConnectionTypeSession;
        connection.requestID = [requestID copy];
        
        self.baseRequests[requestID] = connection;
    }
    
    return self.baseRequests[requestID];
}


#pragma mark - Private Methods (Connections)

- (ALPHARequestState *)requestStateForConnection:(NSURLConnection *)connection;
{
    NSValue *key = [NSValue valueWithNonretainedObject:connection];
    ALPHARequestState *state = [self.connectionStates objectForKey:key];
    if (!state) {
        state = [[ALPHARequestState alloc] init];
        state.requestID = [[self class] nextRequestID];
        [self.connectionStates setObject:state forKey:key];
    }
    
    return state;
}

- (NSString *)requestIDForConnection:(NSURLConnection *)connection;
{
    return [self requestStateForConnection:connection].requestID;
}

- (void)setResponse:(NSURLResponse *)response forConnection:(NSURLConnection *)connection;
{
    [self requestStateForConnection:connection].response = response;
}

- (NSURLResponse *)responseForConnection:(NSURLConnection *)connection;
{
    return [self requestStateForConnection:connection].response;
}

- (void)setRequest:(NSURLRequest *)request forConnection:(NSURLConnection *)connection;
{
    [self requestStateForConnection:connection].request = request;
}

- (NSURLRequest *)requestForConnection:(NSURLConnection *)connection;
{
    return [self requestStateForConnection:connection].request;
}

- (void)setAccumulatedData:(NSMutableData *)data forConnection:(NSURLConnection *)connection;
{
    ALPHARequestState *requestState = [self requestStateForConnection:connection];
    requestState.dataAccumulator = data;
}

- (void)addAccumulatedData:(NSData *)data forConnection:(NSURLConnection *)connection;
{
    NSMutableData *dataAccumulator = [self requestStateForConnection:connection].dataAccumulator;
    
    [dataAccumulator appendData:data];
}

- (NSData *)accumulatedDataForConnection:(NSURLConnection *)connection;
{
    return [self requestStateForConnection:connection].dataAccumulator;
}

// This removes storing the accumulated request/response from the dictionary so we can release connection
- (void)connectionFinished:(NSURLConnection *)connection;
{
    ALPHARequestState *connectionState = [self requestStateForConnection:connection];
    
    ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:connection];
    networkConnection.request = [ALPHANetworkRequest networkRequestWithURLRequest:connectionState.request];
    networkConnection.response = [ALPHANetworkResponse networkResponseWithURLResponse:connectionState.response request:connectionState.request];
    networkConnection.requestID = connectionState.requestID;
    
    networkConnection.responseData = connectionState.dataAccumulator;
    
    NSValue *key = [NSValue valueWithNonretainedObject:connection];
    [self.connectionStates removeObjectForKey:key];
}

#pragma mark - Private Methods (Tasks)

- (ALPHARequestState *)requestStateForTask:(NSURLSessionTask *)task;
{
    NSValue *key = [NSValue valueWithNonretainedObject:task];
    ALPHARequestState *state = [_connectionStates objectForKey:key];
    if (!state) {
        state = [[ALPHARequestState alloc] init];
        state.requestID = [[self class] nextRequestID];
        [self.connectionStates setObject:state forKey:key];
    }
    
    return state;
}

- (NSString *)requestIDForTask:(NSURLSessionTask *)task;
{
    return [self requestStateForTask:task].requestID;
}

- (void)setResponse:(NSURLResponse *)response forTask:(NSURLSessionTask *)task;
{
    [self requestStateForTask:task].response = response;
}

- (NSURLResponse *)responseForTask:(NSURLSessionTask *)task
{
    return [self requestStateForTask:task].response;
}

- (void)setRequest:(NSURLRequest *)request forTask:(NSURLSessionTask *)task;
{
    [self requestStateForTask:task].request = request;
}

- (NSURLRequest *)requestForTask:(NSURLSessionTask *)task;
{
    return [self requestStateForTask:task].request;
}

- (void)setAccumulatedData:(NSMutableData *)data forTask:(NSURLSessionTask *)task;
{
    ALPHARequestState *requestState = [self requestStateForTask:task];
    requestState.dataAccumulator = data;
}

- (void)addAccumulatedData:(NSData *)data forTask:(NSURLSessionTask *)task;
{
    NSMutableData *dataAccumulator = [self requestStateForTask:task].dataAccumulator;
    
    [dataAccumulator appendData:data];
}

- (NSData *)accumulatedDataForTask:(NSURLSessionTask *)task;
{
    return [self requestStateForTask:task].dataAccumulator;
}

// This removes storing the accumulated request/response from the dictionary so we can release task
- (void)taskFinished:(NSURLSessionTask *)task;
{
    ALPHARequestState *connectionState = [self requestStateForTask:task];
    
    ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:task];
    networkConnection.request = [ALPHANetworkRequest networkRequestWithURLRequest:connectionState.request];
    networkConnection.response = [ALPHANetworkResponse networkResponseWithURLResponse:connectionState.response request:connectionState.request];
    networkConnection.requestID = connectionState.requestID;
    networkConnection.responseData = connectionState.dataAccumulator;

    NSValue *key = [NSValue valueWithNonretainedObject:task];
    [self.connectionStates removeObjectForKey:key];
}

@end

@implementation ALPHANetworkSource (NSURLConnectionHelpers)

- (void)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;
{
    [self performBlock:^{
        [self setRequest:request forConnection:connection];
        
        ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:connection];
        networkConnection.timing.connectionStartDate = [NSDate date];
        networkConnection.redirectResponse = [ALPHANetworkResponse networkResponseWithURLResponse:response request:request];
        
        if (networkConnection.redirectResponse)
        {
            networkConnection.timing.redirectDate = [NSDate date];
        }
        
        [networkConnection updateWithRequest:[ALPHANetworkRequest networkRequestWithURLRequest:request] withResponse:nil];
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    [self performBlock:^{
        
        if ([response respondsToSelector:@selector(copyWithZone:)]) {
            
            // If the request wasn't generated yet, then willSendRequest was not called. This appears to be an inconsistency in documentation
            // and behavior.
            NSURLRequest *request = [self requestForConnection:connection];
            if (!request && [connection respondsToSelector:@selector(currentRequest)]) {
                
                NSLog(@"Alpha Warning: -[ALPHANetworkSource connection:willSendRequest:redirectResponse:] not called, request timestamp may be inaccurate. See Known Issues in the README for more information.");
                
                request = connection.currentRequest;
                [self setRequest:request forConnection:connection];
                
                ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:connection];
                networkConnection.timing.connectionStartDate = [NSDate date];
                [networkConnection updateWithRequest:[ALPHANetworkRequest networkRequestWithURLRequest:request] withResponse:nil];
            }
            
            [self setResponse:response forConnection:connection];
            
            NSMutableData *dataAccumulator = nil;
            if (response.expectedContentLength < 0) {
                dataAccumulator = [[NSMutableData alloc] init];
            } else {
                dataAccumulator = [[NSMutableData alloc] initWithCapacity:(NSUInteger)response.expectedContentLength];
            }
            
            [self setAccumulatedData:dataAccumulator forConnection:connection];
            
            ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:connection];
            
            [networkConnection updateWithRequest:[ALPHANetworkRequest networkRequestWithURLRequest:request] withResponse:nil];
        }
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
{
    // Just to be safe since we're doing this async
    data = [data copy];
    [self performBlock:^{
        [self addAccumulatedData:data forConnection:connection];
    }];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
    [self performBlock:^{
        NSURLResponse *response = [self responseForConnection:connection];
        NSString *requestID = [self requestIDForConnection:connection];
        
        NSData *accumulatedData = [self accumulatedDataForConnection:connection];
        
        [self setResponse:accumulatedData forRequestID:requestID response:response request:[self requestForConnection:connection]];
        
        ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:connection];
        networkConnection.timing.connectionEndDate = [NSDate date];
        
        [self connectionFinished:connection];
    }];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
{
    [self performBlock:^{
        ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:connection];
        networkConnection.timing.connectionEndDate = [NSDate date];
        
        networkConnection.error = [ALPHANetworkError networkErrorWithError:error];
        
        [self connectionFinished:connection];
    }];
}

@end

@implementation ALPHANetworkSource (NSURLSessionTaskHelpers)

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request
{
    [self performBlock:^{
        NSMutableURLRequest *newRequest = [request mutableCopy];
        [session.configuration.HTTPAdditionalHeaders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![newRequest valueForHTTPHeaderField:key]) {
                [newRequest setValue:obj forHTTPHeaderField:key];
            }
        }];
        
        [self setRequest:newRequest forTask:task];
        
        ALPHANetworkRequest *networkRequest = [ALPHANetworkRequest networkRequestWithURLRequest:request];
        ALPHANetworkResponse *networkRedirectResponse = response ? [[ALPHANetworkResponse alloc] initWithURLResponse:response request:request] : nil;
        
        ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:task];
        [networkConnection updateWithRequest:networkRequest withResponse:nil];
        networkConnection.redirectResponse = networkRedirectResponse;
        networkConnection.timing.connectionStartDate = [NSDate date];
        
        if (networkConnection.redirectResponse)
        {
            networkConnection.timing.redirectDate = [NSDate date];
        }
    }];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response;
{
    if ([response respondsToSelector:@selector(copyWithZone:)]) {
        
        // willSendRequest does not exist in NSURLSession. Here's a workaround.
        NSURLRequest *request = [self requestForTask:dataTask];
        if (!request && [dataTask respondsToSelector:@selector(currentRequest)]) {
            
            static BOOL hasLoggedTimestampWarning = NO;
            if (!hasLoggedTimestampWarning) {
                hasLoggedTimestampWarning = YES;
                NSLog(@"Alpha Warning: Some requests' timestamps may be inaccurate. See Known Issues in the README for more information.");
            }
            /// We need to set headers from the session configuration
            NSMutableURLRequest *request = [dataTask.currentRequest mutableCopy];
            
            /// FOr some reason, the currentRequest doesn't always keep the HTTPBody around.
            if (request.HTTPBody == nil && dataTask.originalRequest.HTTPBody) {
                request.HTTPBody = dataTask.originalRequest.HTTPBody;
            }
            
            [session.configuration.HTTPAdditionalHeaders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (![request valueForHTTPHeaderField:key]) {
                    [request setValue:obj forHTTPHeaderField:key];
                }
            }];
            
            [self setRequest:request forTask:dataTask];
            
            ALPHANetworkConnection *connection = [self networkConnectionForObject:dataTask];
            
            ALPHANetworkRequest *networkRequest = [ALPHANetworkRequest networkRequestWithURLRequest:request];
            
            connection.timing.connectionStartDate = [NSDate date];
            [connection updateWithRequest:networkRequest withResponse:nil];
        }
        
        [self setResponse:response forTask:dataTask];
        
        NSMutableData *dataAccumulator = nil;
        if (response.expectedContentLength < 0) {
            dataAccumulator = [[NSMutableData alloc] init];
        } else {
            dataAccumulator = [[NSMutableData alloc] initWithCapacity:(NSUInteger)response.expectedContentLength];
        }
        
        [self setAccumulatedData:dataAccumulator forTask:dataTask];
        
        ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:dataTask];
        
        ALPHANetworkResponse *networkResponse = [ALPHANetworkResponse networkResponseWithURLResponse:response request:[self requestForTask:dataTask]];
        
        [networkConnection updateWithRequest:nil withResponse:networkResponse];
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // Just to be safe since we're doing this async
    data = [data copy];
    [self performBlock:^{
        [self addAccumulatedData:data forTask:dataTask];
    }];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;
{
    [self performBlock:^{
        NSURLResponse *response = [self responseForTask:task];
        NSString *requestID = [self requestIDForTask:task];
        
        NSData *accumulatedData = [self accumulatedDataForTask:task];
        
        if (!error) {
            [self setResponse:accumulatedData
                 forRequestID:requestID
                     response:response
                      request:[self requestForTask:task]];

            
        }
        
        ALPHANetworkConnection *networkConnection = [self networkConnectionForObject:task];
        
        networkConnection.error = [ALPHANetworkError networkErrorWithError:error];
        
        networkConnection.timing.connectionEndDate = [NSDate date];
        
        [self taskFinished:task];
    }];
}

@end
