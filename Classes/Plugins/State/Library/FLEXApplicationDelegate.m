//
//  FLEXApplicationDelegate.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXSystemNotification.h"
#import "FLEXApplicationDelegate.h"
#import "FLEXNotificationCollector.h"

@implementation FLEXApplicationDelegate

- (NSArray *)trackedSelectors
{
    static NSArray *selectors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectors = @[ NSStringFromSelector(@selector(application:didFinishLaunchingWithOptions:)), NSStringFromSelector(@selector(applicationDidBecomeActive:)), NSStringFromSelector(@selector(applicationWillResignActive:)), NSStringFromSelector(@selector(applicationDidReceiveMemoryWarning:)), NSStringFromSelector(@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)), NSStringFromSelector(@selector(application:didFailToRegisterForRemoteNotificationsWithError:)), NSStringFromSelector(@selector(application:didReceiveRemoteNotification:)), NSStringFromSelector(@selector(application:didReceiveLocalNotification:)), NSStringFromSelector(@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)), NSStringFromSelector(@selector(applicationDidEnterBackground:)), NSStringFromSelector(@selector(applicationWillEnterForeground:)) ];
    });
    
    return selectors;
}

/*
- (void)setOriginalDelegate:(id<UIApplicationDelegate>)originalDelegate
{
    _originalDelegate = originalDelegate;
    
    NSLog(@"ORIGINAL: %@", _originalDelegate);
}*/

- (BOOL)respondsToSelector:(SEL)aSelector
{
    //
    // So here we will check if aSelector is in UIApplicationDelegate protocol.
    // If it is, we will return YES, just so we get called and then pass the
    // invocation to original delegate, if that guy responds to it. We only log
    // a couple of methods, not all of them, since it could mess with the app.
    //
    
    NSString* selector = NSStringFromSelector(aSelector);
    
    if ([super respondsToSelector:aSelector])
    {
        return YES;
    }
    else if ([[self trackedSelectors] containsObject:selector])
    {
        return YES;
    }
    else if (self.originalDelegate)
    {
        return [self.originalDelegate respondsToSelector:aSelector];
    }
    else
    {
        return NO;
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //
    // Redirect message to original delegate and act the same as the original delegate
    //
    
    //NSLog(@"DELEGATE MESSAGE: %@", NSStringFromSelector(anInvocation.selector));
    
    //
    // Remote Push notifications
    //
    
    if (anInvocation.selector == @selector(application:didReceiveRemoteNotification:) || anInvocation.selector == @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:))
    {
        //
        // Grab notification data from the invocation
        //
        void* object;
        
        [anInvocation getArgument:&object atIndex:1];
        
        //
        // Get a dictionary
        //
        NSDictionary* userInfo = (__bridge NSDictionary *)object;
        
        FLEXSystemNotification* notification = [FLEXSystemNotification systemNotificationWithRemoteNotification:[userInfo copy]];
        
        [[FLEXNotificationCollector sharedCollector] registerRemoteNotification:notification];
    }
    
    if ([self.originalDelegate respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:self.originalDelegate];
    }
}

@end
