//
//  ALPHANotificationCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 Unifed Sense. All rights reserved.
//

#import <Haystack/Haystack.h>
#import "ALPHAApplicationDelegate.h"

#import "ALPHANotification.h"

#import "ALPHANotificationCollector.h"

NSString *const ALPHANotificationDataIdentifier = @"com.unifiedsense.alpha.data.notification";

@interface ALPHANotificationCollector ()

/*!
 *  Contains string with enabled notification types that
 */
@property (nonatomic, readonly) NSString* enabledNotificationTypes;

/*!
 *  Contains registered remote notification token
 */
@property (nonatomic, strong) NSString* remoteNotificationToken;

/*!
 *  Holds remote registration description based on register calls
 */
@property (nonatomic, strong) NSString* remoteRegistrationDescription;

/*!
 *  Received remote notifications
 */
@property (nonatomic, strong) NSMutableArray* remoteNotifications;

/*!
 *  Currently scheduled local notifications
 */
@property (nonatomic, readonly) NSArray* scheduledLocalNotifications;

/*!
 *  Already fired local notifications
 */
@property (nonatomic, strong) NSMutableArray* firedLocalNotifications;

@end

@implementation ALPHANotificationCollector

#pragma mark - Getters and Setters

- (NSString *)remoteNotificationToken
{
    if (!_remoteNotificationToken)
    {
        return @"Not available";
    }
    
    return _remoteNotificationToken;
}

- (NSString *)remoteRegistrationDescription
{
    if (!_remoteRegistrationDescription)
    {
        return @"Not initiated";
    }
    
    return _remoteRegistrationDescription;
}

- (NSMutableArray *)remoteNotifications
{
    if (!_remoteNotifications)
    {
        _remoteNotifications = [NSMutableArray array];
    }
    
    return _remoteNotifications;
}

- (NSMutableArray *)firedLocalNotifications
{
    if (!_firedLocalNotifications)
    {
        _firedLocalNotifications = [NSMutableArray array];
    }
    
    return _firedLocalNotifications;
}

- (NSArray *)scheduledLocalNotifications
{
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    NSMutableArray *systemNotifications = [NSMutableArray array];
    
    for (UILocalNotification *notification in notifications)
    {
        [systemNotifications addObject:[ALPHANotification notificationWithLocalNotification:notification]];
    }
    
    return [systemNotifications copy];
}

#pragma mark - Data Collector

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHANotificationDataIdentifier];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delegateEvent:) name:ALPHAApplicationDelegateNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)collectDataForIdentifier:(NSString *)identifier completion:(void (^)(ALPHAScreenModel *, NSError *))completion
{
    if (completion)
    {
        completion([self collectRootData], nil);
    }
}

- (ALPHAScreenModel *)collectRootData
{
    NSMutableArray* sections = [NSMutableArray array];
    
    //
    // Settings section
    //
    
    NSDictionary* sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.settings",
                                   @"items" : @[
                                           @{ @"Status" : [[self enabledNotificationTypes] capitalizedString] },
                                           @{ @"APNS" : self.remoteRegistrationDescription },
                                           @{ @"Token" : self.remoteNotificationToken }
                                   ],
                                   @"title" : @"Settings" };
    
    [sections addObject:[ALPHAScreenSection dataSectionWithDictionary:sectionData]];
    
    //
    // Remote notification section
    //
    
    if (self.remoteNotifications.count)
    {
        sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.remote",
                         @"items" : [self screenItemsForNotificationArray:self.remoteNotifications],
                         @"style" : @(UITableViewCellStyleSubtitle),
                         @"title" : @"Remote" };
        
        
        [sections addObject:[ALPHAScreenSection dataSectionWithDictionary:sectionData]];
    }
    
    
    //
    // Scheduled Local notification section
    //
    
    if (self.firedLocalNotifications.count)
    {
    
        sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.local.fired",
                         @"items" : [self screenItemsForNotificationArray:self.firedLocalNotifications],
                         @"style" : @(UITableViewCellStyleSubtitle),
                         @"title" : @"Local Fired" };
    
    
        [sections addObject:[ALPHAScreenSection dataSectionWithDictionary:sectionData]];
    }
    
    //
    // Scheduled Local notification section
    //
    
    NSArray *localNotifications = self.scheduledLocalNotifications;
    
    if (localNotifications.count)
    {
    
        sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.notification.local.scheduled",
                         @"items" : [self screenItemsForNotificationArray:localNotifications],
                         @"style" : @(UITableViewCellStyleSubtitle),
                         @"title" : @"Local Scheduled" };
    
    
        [sections addObject:[ALPHAScreenSection dataSectionWithDictionary:sectionData]];
    }
    
    //
    // Data model
    //
    
    ALPHAScreenModel* dataModel = [[ALPHAScreenModel alloc] initWithIdentifier:ALPHANotificationDataIdentifier];
    dataModel.title = @"Notifications";
    dataModel.sections = sections.copy;
    
    return dataModel;
}


#pragma mark - Private Methods

/*!
 *  Register notification events
 *
 *  @param notification notification of event
 */
- (void)delegateEvent:(NSNotification *)notification
{
    NSInvocation *anInvocation = notification.object;
    
    //
    // Remote Push notifications hook
    //
    
    if (anInvocation.selector == @selector(application:didReceiveRemoteNotification:) || anInvocation.selector == @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:))
    {
        //
        // Get a dictionary
        //
        NSDictionary* userInfo = [anInvocation hs_argumentAtIndex:1];
        
        ALPHANotification* notification = [ALPHANotification notificationWithRemoteNotification:[userInfo copy]];
        
        if (anInvocation.selector == @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:))
        {
            notification.isFetch = YES;
        }
        
        [self.remoteNotifications addObject:notification];
    }
    
    //
    // Launch Options Notification hook
    //
    
    else if (anInvocation.selector == @selector(application:didFinishLaunchingWithOptions:))
    {
        NSDictionary *launchOptions = [anInvocation hs_argumentAtIndex:1];
        
        //
        // Remote Notifications
        //
        
        if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey])
        {
            ALPHANotification* notification = [ALPHANotification notificationWithRemoteNotification:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
            [self.remoteNotifications addObject:notification];
        }
        
        if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey])
        {
            ALPHANotification* notification = [ALPHANotification notificationWithLocalNotification:launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]];
            [self.firedLocalNotifications addObject:notification];
        }
    }
    
    //
    // Push Notification Registration hook
    //
    
    else if (anInvocation.selector == @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:))
    {
        NSData* deviceToken = [anInvocation hs_argumentAtIndex:1];
        
        NSString* tokenString = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
        
        self.remoteNotificationToken = tokenString;
        self.remoteRegistrationDescription = @"Registered";
    }
    else if (anInvocation.selector == @selector(application:didFailToRegisterForRemoteNotificationsWithError:))
    {
        NSError *error = [anInvocation hs_argumentAtIndex:1];
        self.remoteRegistrationDescription = error.localizedDescription;
    }
    else if (anInvocation.selector == @selector(application:didReceiveLocalNotification:))
    {
        UILocalNotification *localNotifiation = [anInvocation hs_argumentAtIndex:1];
        
        ALPHANotification *notification = [ALPHANotification notificationWithLocalNotification:localNotifiation];
        
        [self.firedLocalNotifications addObject:notification];
    }
}

- (NSArray *)screenItemsForNotificationArray:(NSArray *)notifications
{
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHANotification* notification in notifications)
    {
        NSString *text = notification.alertBody.length ? notification.alertBody : [notification.fireDate description];
        NSString *detail = notification.alertBody.length ? [notification.fireDate description] : @"";
        
        [items addObject:@{ text : detail }];
    }
    
    return items.copy;
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

@end
