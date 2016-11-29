//
//  ALPHANotificationPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

#import "ALPHANotificationPermission.h"

@implementation ALPHANotificationPermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.audio"];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    BOOL notificationsOn = ([[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone);
    
    return notificationsOn ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied;
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __nonnull note)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
        
        if (completion)
        {
            completion(self, [self status], nil);
        }
    }];
    
    UIUserNotificationSettings *userNotificationSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];

    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSettings];
}

- (NSString *)name
{
    return @"Notifications";
}

@end
