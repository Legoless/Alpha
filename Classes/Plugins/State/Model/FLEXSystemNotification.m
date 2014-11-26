//
//  FLEXSystemNotification.m
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXSystemNotification.h"

@implementation FLEXSystemNotification

+ (instancetype)systemNotificationWithLocalNotification:(UILocalNotification *)notification
{
    FLEXSystemNotification *systemNotification = [[FLEXSystemNotification alloc] init];
    
    systemNotification.fireDate = notification.fireDate;
    systemNotification.alertBody = notification.alertBody;
    systemNotification.hasAction = notification.hasAction;
    systemNotification.alertAction = notification.alertAction;
    systemNotification.alertLaunchImage = notification.alertLaunchImage;
    systemNotification.soundName = notification.soundName;
    systemNotification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber;
    systemNotification.userInfo = notification.userInfo;
    systemNotification.category = notification.category;
    
    return systemNotification;
}

+ (instancetype)systemNotificationWithRemoteNotification:(NSDictionary *)dictionary
{
    return nil;
}

@end
