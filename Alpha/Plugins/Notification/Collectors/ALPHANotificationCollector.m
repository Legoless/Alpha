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

#import "ALPHANotificationModel.h"

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

- (ALPHAModel *)model
{
    ALPHANotificationModel *model = [[ALPHANotificationModel alloc] initWithIdentifier:ALPHANotificationDataIdentifier];
    model.enabledNotificationTypes = self.enabledNotificationTypes;
    model.remoteNotificationToken = self.remoteNotificationToken;
    model.remoteRegistrationDescription = self.remoteRegistrationDescription;
    model.remoteNotifications = self.remoteNotifications;
    model.scheduledLocalNotifications = self.scheduledLocalNotifications;
    model.firedLocalNotifications = self.firedLocalNotifications;
    
    NSLog(@"NOTIFICATION MODEL..");
    
    return model;
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
