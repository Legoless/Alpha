//
//  ALPHAApplicationDelegate.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "FLEXSystemNotification.h"
#import "FLEXNotificationCollector.h"

#import "ALPHAApplicationDelegate.h"

@implementation ALPHAApplicationDelegate

- (instancetype)initWithDelegate:(id<UIApplicationDelegate>)delegate
{
    self = [super init];
    
    if (self)
    {
        NSMutableArray* selectors = [@[ NSStringFromSelector(@selector(application:didFinishLaunchingWithOptions:)), NSStringFromSelector(@selector(applicationDidBecomeActive:)), NSStringFromSelector(@selector(applicationWillResignActive:)), NSStringFromSelector(@selector(applicationDidReceiveMemoryWarning:)), NSStringFromSelector(@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)), NSStringFromSelector(@selector(application:didFailToRegisterForRemoteNotificationsWithError:)), NSStringFromSelector(@selector(application:didReceiveRemoteNotification:)), NSStringFromSelector(@selector(application:didReceiveLocalNotification:)),  NSStringFromSelector(@selector(applicationDidEnterBackground:)), NSStringFromSelector(@selector(applicationWillEnterForeground:)) ] mutableCopy];
        
        //
        // Apple print's out a nasty error warning for remote notifications in background, so we will not track this selector
        // unless original delegate actually implements it.
        //
        
        SEL selector = @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:);
        
        if ([delegate respondsToSelector:selector])
        {
            [selectors addObject:NSStringFromSelector(selector)];
            
            self.object = delegate;
        }
        
        self.trackedSelectors = [selectors copy];
    }
    
    return self;
}

- (void)trackInvocation:(NSInvocation *)anInvocation
{
    //
    // Remote Push notifications hook
    //
    
    if (anInvocation.selector == @selector(application:didReceiveRemoteNotification:) || anInvocation.selector == @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:))
    {
        //
        // Get a dictionary
        //
        NSDictionary* userInfo = [anInvocation hs_argumentAtIndex:1];
        
        FLEXSystemNotification* notification = [FLEXSystemNotification systemNotificationWithRemoteNotification:[userInfo copy]];
        
        if (anInvocation.selector == @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:))
        {
            notification.isFetch = YES;
        }
        
        //[[FLEXNotificationCollector sharedCollector] registerRemoteNotification:notification];
    }
    
    //
    // Push notification token hook
    //
    
    else if (anInvocation.selector == @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:))
    {
        //NSData* deviceToken = [self argumentInInvocation:anInvocation atIndex:1];
        
        //NSString* tokenString = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
        
        //[FLEXNotificationCollector sharedCollector].remoteNotificationToken = tokenString;
    }
    else if (anInvocation.selector == @selector(application:didFailToRegisterForRemoteNotificationsWithError:))
    {
        //
        // Log error
        //
    }
}

@end
