//
//  ALPHABonjourSource.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHABonjourDataConnection.h"

#import "ALPHABonjourSource.h"
#import "ALPHANetworkObject.h"

@interface ALPHABonjourSource () <ALPHABonjourDataConnectionDelegate>

@property (nonatomic, copy) ALPHADataSourceRequestCompletion completion;
@property (nonatomic, copy) ALPHADataSourceRequestVerification verification;

@end

@implementation ALPHABonjourSource

#pragma mark - Getters and Setters

- (void)setConnection:(ALPHABonjourConnection *)connection
{
    _connection = connection;
    connection.delegate = self;
}

#pragma mark - Initialziation

- (instancetype)initWithConnection:(ALPHABonjourConnection *)connection
{
    self = [super init];
    
    if (self)
    {
        self.connection = connection;
    }
    
    return self;
}

#pragma mark - ALPHADataSource

- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] init];
    
    object.object = request;
    object.parameters = @{ ALPHANetworkObjectVerificationKey : @(YES) };
    
    self.verification = completion;
    
    NSError* error = nil;
    
    if (![self.connection isOpen])
    {
        [self.connection open];
    }
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(NO);
        }
    }
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestCompletion)completion
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] init];
    
    object.object = request;
    
    self.completion = completion;
    
    //NSLog(@"SETTING COMPLETION: %@", completion);
    
    NSError* error = nil;
    
    if (![self.connection isOpen])
    {
        [self.connection open];
    }
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        //NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(nil, error);
        }
    }
}

- (void)canPerformAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestVerification)completion;
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] init];
    object.object = action;
    object.parameters = @{ ALPHANetworkObjectVerificationKey : @(YES) };
    
    self.verification = completion;
    
    NSError* error = nil;
    
    if (![self.connection isOpen])
    {
        [self.connection open];
    }
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(NO);
        }
    }

}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestCompletion)completion
{
    ALPHANetworkObject* object = [[ALPHANetworkObject alloc] init];
    
    object.object = action;
    self.completion = completion;
    
    NSError* error = nil;
    
    if (![self.connection isOpen])
    {
        [self.connection open];
    }
    
    [self.connection sendObject:object error:&error];
    
    if (error)
    {
        NSLog(@"Error sending object: %@", error);
        
        if (completion)
        {
            completion(nil, error);
        }
    }
}

#pragma mark - DTBonjourDataConnectionDelegate

- (void)connection:(ALPHABonjourDataConnection *)connection didReceiveObject:(ALPHANetworkObject *)object
{
    //
    // Check if it errored
    //
    
    NSLog(@"CLIENT RECEIVED OBJECT: %@", object);
    
    id serializedObject = object.object;
    
    NSLog(@"CLIENT SERIALIZED: %@", serializedObject);
    NSLog(@"COMPLETION: %@", self.completion);
    
    if (object.error)
    {
        if (self.verification)
        {
            self.verification(NO);
        
            self.verification = nil;
        }
        else if (self.completion)
        {
            self.completion (nil, object.error);
            
            self.completion = nil;
        }
    }
    else if (object.parameters[ALPHANetworkObjectVerificationKey] && self.verification)
    {
        self.verification ([object.parameters[ALPHANetworkObjectVerificationKey] boolValue]);
        
        self.verification = nil;
    }
    else if (serializedObject && self.completion)
    {
        self.completion (serializedObject, nil);
        
        self.completion = nil;
    }
}

- (void)connectionDidClose:(ALPHABonjourDataConnection *)connection
{
    self.connection = nil;
    
    self.verification = nil;
    self.completion = nil;
}

#pragma mark - Private methods

@end
