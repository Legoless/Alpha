//
//  ALPHAPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "NSString+Identifier.h"
#import "ALPHAPermission.h"

NSString* NSStringFromAuthorizationStatus (ALPHAApplicationAuthorizationStatus status)
{
    switch (status)
    {
        case ALPHAApplicationAuthorizationStatusNotDetermined:
            return @"Not Determined";
        case ALPHAApplicationAuthorizationStatusRestricted:
            return @"Restricted";
        case ALPHAApplicationAuthorizationStatusDenied:
            return @"Denied";
        case ALPHAApplicationAuthorizationStatusAuthorized:
            return @"Authorized";
        case ALPHAApplicationAuthorizationStatusUnsupported:
            return @"Unsupported";
        case ALPHAApplicationAuthorizationStatusAskAgain:
            return @"Ask Again";
        case ALPHAApplicationAuthorizationStatusDoNotAskAgain:
            return @"Do Not Ask Again";
        case ALPHAApplicationAuthorizationStatusMissingFramework:
            return @"Not Linked";
    }
}

@interface ALPHAPermission ()

@property (nonatomic, copy, readwrite) NSString* identifier;

@end

@implementation ALPHAPermission

- (instancetype)init
{
    return [self initWithIdentifier:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    
    if (self)
    {
        self.identifier = identifier;
    }
    
    return self;
}

- (NSString *)name
{
    NSString *name = NSStringFromClass(self.class);
    
    name = [name stringByReplacingOccurrencesOfString:@"Permission" withString:@""];
    
    return [name alpha_cleanCodeIdentifier];
}

- (NSString *)statusString
{
    return NSStringFromAuthorizationStatus(self.status);
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    // Abstract
    
    NSLog(@"Requesting permission: %@", self.identifier);
}

- (void)resetPermission:(void (^)(BOOL))completion
{
    if (completion)
    {
        completion (NO);
    }
}

+ (NSArray *)allPermissions
{
    return nil;
}

@end
