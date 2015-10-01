//
//  ALPHANotificationConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHANotificationModel.h"
#import "ALPHANotificationConverter.h"
#import "ALPHANotification.h"
#import "ALPHATableScreenModel.h"

@interface ALPHANotificationConverter ()

@end

@implementation ALPHANotificationConverter

- (BOOL)canConvertObject:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHANotificationModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHAModel *)model
{
    ALPHANotificationModel* notificationModel = (ALPHANotificationModel *)model;
    
    NSMutableArray* sections = [NSMutableArray array];
    
    //
    // Settings section
    //
    
    NSDictionary* sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.settings",
                                   @"items" : @[
                                           @{ @"Status" : [notificationModel.enabledNotificationTypes capitalizedString] },
                                           @{ @"APNS" : notificationModel.remoteRegistrationDescription },
                                           @{ @"Token" : notificationModel.remoteNotificationToken }
                                           ],
                                   @"style" : @(UITableViewCellStyleValue1),
                                   @"headerText" : @"Settings" };
    
    [sections addObject:[ALPHAScreenSection screenSectionWithDictionary:sectionData]];
    
    //
    // Remote notification section
    //
    
    if (notificationModel.remoteNotifications.count)
    {
        sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.remote",
                         @"items" : [self screenItemsForNotifications:notificationModel.remoteNotifications],
                         @"style" : @(UITableViewCellStyleSubtitle),
                         @"headerText" : @"Remote" };
        
        
        [sections addObject:[ALPHAScreenSection screenSectionWithDictionary:sectionData]];
    }
    
    
    //
    // Scheduled Local notification section
    //
    
    if (notificationModel.firedLocalNotifications.count)
    {
        
        sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.local.fired",
                         @"items" : [self screenItemsForNotifications:notificationModel.firedLocalNotifications],
                         @"style" : @(UITableViewCellStyleSubtitle),
                         @"headerText" : @"Local Fired" };
        
        
        [sections addObject:[ALPHAScreenSection screenSectionWithDictionary:sectionData]];
    }
    
    //
    // Scheduled Local notification section
    //
    
    NSArray *localNotifications = notificationModel.scheduledLocalNotifications;
    
    if (localNotifications.count)
    {
        
        sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.local.scheduled",
                         @"items" : [self screenItemsForNotifications:localNotifications],
                         @"style" : @(UITableViewCellStyleSubtitle),
                         @"headerText" : @"Local Scheduled" };
        
        
        [sections addObject:[ALPHAScreenSection screenSectionWithDictionary:sectionData]];
    }
    
    //
    // Data model
    //
    
    ALPHATableScreenModel* dataModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
    dataModel.title = @"Notifications";
    dataModel.sections = sections.copy;
    
    return dataModel;
}

- (NSArray *)screenItemsForNotifications:(NSArray *)notifications
{
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHANotification* notification in notifications)
    {
        [items addObject:notification.screenItem];
    }
    
    return items.copy;
}


@end
