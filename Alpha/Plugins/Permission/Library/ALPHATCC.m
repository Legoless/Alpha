//
//  ALPHATCC.m
//  Alpha
//
//  Created by Dal Rupnik on 18/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#include <dlfcn.h>

#import "ALPHARuntimeUtility.h"

#import "ALPHATCC.h"


@interface ALPHATCC : NSObject

@property (nonatomic, assign) void *tccHandle;

+ (instancetype)shared;

@end

@implementation ALPHATCC

- (void *)tccHandle
{
    if (!_tccHandle)
    {
        _tccHandle = [ALPHARuntimeUtility openPrivateDynamicLibrary:@"TCC"];
    }
    
    return _tccHandle;
}

+ (instancetype)shared
{
    static id shared;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^
    {
        shared = [[self alloc] init];
    });
    
    return shared;
}

@end

#pragma mark - TCC Implementation

int TCCAccessRequest(NSString *service, NSString *message, int completion)
{
    void *handle = [[ALPHATCC shared] tccHandle];
    
    if (handle)
    {
        int (*function)(NSString *, NSString *, int) = dlsym(handle, "TCCAccessRequest");
        
        if (function)
        {
            return function(service, message, completion);
        }
        
    }


    return 0;
}

int TCCAccessPreflight(NSString *service)
{
    void *handle = [[ALPHATCC shared] tccHandle];
    
    if (handle)
    {
        int (*function)(NSString *) = dlsym(handle, "TCCAccessPreflight");
        
        if (function)
        {
            return function(service);
        }
    }
    
    return 0;
}

int TCCAccessRestricted(NSString *service)
{
    void *handle = [[ALPHATCC shared] tccHandle];
    
    if (handle)
    {
        int (*function)(NSString *) = dlsym(handle, "TCCAccessRestricted");
        
        if (function)
        {
            return function(service);
        }
    }
    
    return 0;
}

/*
int TCCAccessCopyInformationForBundle(NSString *bundleIdentifier)
{
    void *handle = [[ALPHATCC shared] tccHandle];
    
    if (handle)
    {
        int (*function)(NSString *) = dlsym(handle, "TCCAccessCopyInformationForBundle");
        
        if (function)
        {
            return function(bundleIdentifier);
        }
    }
    
    return 0;
}

int TCCAccessCopyInformation(NSString* service, SEL a2)
{
    [ALPHARuntimeUtility loadPrivateFramework:@"Preferences"];
    
    SEL selector = NSSelectorFromString(@"copyTCCBundleForService:");
    
    void *handle = [[ALPHATCC shared] tccHandle];
    
    if (handle)
    {
        int (*function)(NSString *, SEL) = dlsym(handle, "TCCAccessCopyInformation");
        
        if (function)
        {
            return function(service, selector);
        }
    }
    
    return 0;
}

int TCCAccessSetForBundle (NSString *service, CFBundleRef bundle, BOOL access)
{
    void *handle = [[ALPHATCC shared] tccHandle];
    
    if (handle)
    {
        int (*function)(NSString *, CFBundleRef, BOOL) = dlsym(handle, "TCCAccessSetForBundle");
        
        if (function)
        {
            return function(service, bundle, access);
        }
    }
    
    return 0;
}*/
