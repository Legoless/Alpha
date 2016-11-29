//
//  ALPHAApplicationDelegate.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationDelegate.h"

NSString *const ALPHAApplicationDelegateNotification = @"kALPHAApplicationDelegateNotification";

@implementation ALPHAApplicationDelegate

- (instancetype)initWithDelegate:(id<UIApplicationDelegate>)delegate
{
    self = [super init];
    
    if (self)
    {
        NSMutableArray* selectors = [@[
                                       NSStringFromSelector(@selector(application:didFinishLaunchingWithOptions:)),
                                       NSStringFromSelector(@selector(applicationDidBecomeActive:)),
                                       NSStringFromSelector(@selector(applicationWillResignActive:)),
                                       NSStringFromSelector(@selector(applicationDidReceiveMemoryWarning:)),
                                       NSStringFromSelector(@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)),
                                       NSStringFromSelector(@selector(application:didFailToRegisterForRemoteNotificationsWithError:)),
                                       NSStringFromSelector(@selector(application:didReceiveRemoteNotification:)),
                                       NSStringFromSelector(@selector(application:didReceiveLocalNotification:)),
                                       NSStringFromSelector(@selector(applicationDidEnterBackground:)),
                                       NSStringFromSelector(@selector(applicationWillEnterForeground:))
                                    ] mutableCopy];
        
        //
        // Apple print's out a nasty error warning for remote notifications in background, so we will not track this selector
        // unless original delegate actually implements it.
        //
        
        SEL selector = @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:);
        
        if ([delegate respondsToSelector:selector])
        {
            [selectors addObject:NSStringFromSelector(selector)];
        }
        
        self.object = delegate;
        
        self.trackedSelectors = [selectors copy];
    }
    
    return self;
}

- (void)trackInvocation:(NSInvocation *)anInvocation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAApplicationDelegateNotification object:anInvocation];
}

@end
