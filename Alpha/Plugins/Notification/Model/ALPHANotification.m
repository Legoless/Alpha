//
//  ALPHANotification.m
//  Alpha
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHARequest.h"

#import "ALPHANotification.h"
#import "ALPHASerialization.h"

@implementation ALPHANotification

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (instancetype)notificationWithLocalNotification:(UILocalNotification *)localNotification
{
    ALPHANotification *notification = [[ALPHANotification alloc] init];
    
    notification.fireDate = localNotification.fireDate;
    notification.alertBody = localNotification.alertBody;
    notification.hasAction = localNotification.hasAction;
    notification.alertAction = localNotification.alertAction;
    notification.alertLaunchImage = localNotification.alertLaunchImage;
    notification.soundName = localNotification.soundName;
    notification.applicationIconBadgeNumber = localNotification.applicationIconBadgeNumber;
    notification.userInfo = localNotification.userInfo;
    notification.category = localNotification.category;
    
    return notification;
}

+ (instancetype)notificationWithRemoteNotification:(NSDictionary *)userInfo
{
    ALPHANotification *notification = [[ALPHANotification alloc] init];
    
    notification.alertBody = userInfo[@"alert"];
    notification.receivedDate = [NSDate date];
    notification.userInfo = userInfo;
    notification.isRemote = YES;
    notification.soundName = userInfo[@"sound"];
    notification.applicationIconBadgeNumber = [userInfo[@"badge"] integerValue];
    
    return notification;
}

- (ALPHAScreenItem *)screenItem
{
    ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
    
    item.titleText = self.alertBody.length ? self.alertBody : [self.fireDate description];
    item.detailText = self.alertBody.length ? [self.fireDate description] : @"";
    item.object = [ALPHARequest requestForObject:self];
    
    return item;
}

@end
