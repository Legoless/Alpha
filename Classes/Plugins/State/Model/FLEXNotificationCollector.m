//
//  FLEXNotificationInformationCollector.m
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXSystemNotification.h"

#import "FLEXNotificationCollector.h"

@interface FLEXNotificationCollector ()

@property

@end

@implementation FLEXNotificationCollector

- (NSArray *)localNotifications
{
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    NSMutableArray *systemNotifications = [NSMutableArray array];
    
    for (UILocalNotification *notification in notifications)
    {
        [systemNotifications addObject:[FLEXSystemNotification systemNotificationWithLocalNotification:notification]];
    }
    
    return [systemNotifications copy];
}

- (NSString *)enabledNotificationTypes
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)])
    {
        return [self stringForUserNotificationSettings:[[UIApplication sharedApplication] currentUserNotificationSettings]];
    }
    else
    {
        return [self stringForEnabledRemoteNotificationTypes:[UIApplication sharedApplication].enabledRemoteNotificationTypes];
    }
}


- (NSString *)stringForEnabledRemoteNotificationTypes:(UIRemoteNotificationType)notificationType
{
    NSMutableArray *types = [NSMutableArray array];
    
    if ((notificationType & UIRemoteNotificationTypeAlert) != 0)
    {
        [types addObject:@"alert"];
    }
    
    if ((notificationType & UIRemoteNotificationTypeBadge) != 0)
    {
        [types addObject:@"badge"];
    }
    
    if ((notificationType & UIRemoteNotificationTypeNewsstandContentAvailability) != 0)
    {
        [types addObject:@"content"];
    }
    
    if ((notificationType & UIRemoteNotificationTypeSound) != 0)
    {
        [types addObject:@"sound"];
    }
    
    return types.count ? [types componentsJoinedByString:@", "] : @"none";
}

- (NSString *)stringForUserNotificationSettings:(UIUserNotificationSettings *)settings
{
    NSMutableArray *types = [NSMutableArray array];
    
    if ((settings.types & UIUserNotificationTypeAlert) != 0)
    {
        [types addObject:@"alert"];
    }
    
    if ((settings.types & UIUserNotificationTypeBadge) != 0)
    {
        [types addObject:@"badge"];
    }
    
    if ((settings.types & UIUserNotificationTypeSound) != 0)
    {
        [types addObject:@"sound"];
    }
    
    return types.count ? [types componentsJoinedByString:@", "] : @"none";
}

- (void)registerRemoteNotification:(FLEXSystemNotification *)notification

@end
