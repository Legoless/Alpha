//
//  ALPHANotificationPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

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
    UIUserNotificationSettings *userNotificationSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];

    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSettings];
    
    if (completion)
    {
        completion(self, [self status], nil);
    }
}

- (NSString *)name
{
    return @"Notifications";
}

@end
