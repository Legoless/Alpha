//
//  ALPHANotification.m
//  Alpha
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHANotification.h"

@implementation ALPHANotification

+ (instancetype)notificationWithLocalNotification:(UILocalNotification *)notification
{
    ALPHANotification *systemNotification = [[ALPHANotification alloc] init];
    
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

+ (instancetype)notificationWithRemoteNotification:(NSDictionary *)dictionary
{
    ALPHANotification *systemNotification = [[ALPHANotification alloc] init];
    
    systemNotification.alertBody = @"Test";
    systemNotification.receivedDate = [NSDate date];
    systemNotification.userInfo = dictionary;
    systemNotification.isRemote = YES;
    
    return systemNotification;
}

@end
