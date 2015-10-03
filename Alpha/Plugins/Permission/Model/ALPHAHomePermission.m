//
//  ALPHAHomePermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import HomeKit;

#import "ALPHAHomePermission.h"

@interface ALPHAHomePermission ()

@property (nonatomic, strong) HMHomeManager *homeManager;

@end

@implementation ALPHAHomePermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.home"];
}

#pragma mark - Public Methods

- (NSString *)name
{
    return @"Home";
}

- (ALPHAApplicationAuthorizationStatus)status
{
    return ALPHAApplicationAuthorizationStatusNotDetermined;
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    if (self.homeManager == nil)
    {
        self.homeManager = [[HMHomeManager alloc] init];
    }
}

@end
