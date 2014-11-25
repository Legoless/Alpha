//
//  FLEXApplicationDelegate.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXApplicationDelegate.h"

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
    
    if ([self.originalDelegate respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:self.originalDelegate];
    }
}

/*
- (UIWindow *)window
{
    return self.originalDelegate.window;
}

- (void)setWindow:(UIWindow *)window
{
    self.originalDelegate.window = window;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationDidFinishLaunching:)])
    {
        [self.originalDelegate applicationDidFinishLaunching:application];
    }
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([self.originalDelegate respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)])
    {
        return [self.originalDelegate application:application willFinishLaunchingWithOptions:launchOptions];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
    {
        return [self.originalDelegate application:application didFinishLaunchingWithOptions:launchOptions];
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationDidBecomeActive:)])
    {
        [self.originalDelegate applicationDidBecomeActive:application];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationWillResignActive:)])
    {
        [self.originalDelegate applicationWillResignActive:application];
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([self.originalDelegate respondsToSelector:@selector(application:handleOpenURL:)])
    {
        return [self.originalDelegate application:application handleOpenURL:url];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([self.originalDelegate respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)])
    {
        return [self.originalDelegate application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)])
    {
        [self.originalDelegate applicationDidReceiveMemoryWarning:application];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationWillTerminate:)])
    {
        [self.originalDelegate applicationWillTerminate:application];
    }
}

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationSignificantTimeChange:)])
    {
        [self.originalDelegate applicationSignificantTimeChange:application];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    if ([self.originalDelegate respondsToSelector:@selector(application:willChangeStatusBarOrientation:duration:)])
    {
        [self.originalDelegate application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didChangeStatusBarOrientation:)])
    {
        [self.originalDelegate application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    if ([self.originalDelegate respondsToSelector:@selector(application:willChangeStatusBarFrame:)])
    {
        [self.originalDelegate application:application willChangeStatusBarFrame:newStatusBarFrame];
    }
}
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didChangeStatusBarFrame:)])
    {
        [self.originalDelegate application:application didChangeStatusBarFrame:oldStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)])
    {
        [self.originalDelegate application:application didRegisterUserNotificationSettings:notificationSettings];
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)])
    {
        [self.originalDelegate application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)])
    {
        [self.originalDelegate application:application didFailToRegisterForRemoteNotificationsWithError:error];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didReceiveRemoteNotification:)])
    {
        [self.originalDelegate application:application didReceiveRemoteNotification:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didReceiveLocalNotification:)])
    {
        [self.originalDelegate application:application didReceiveLocalNotification:notification];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
    if ([self.originalDelegate respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)])
    {
        [self.originalDelegate application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    if ([self.originalDelegate respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)])
    {
        [self.originalDelegate application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    if ([self.originalDelegate respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)])
    {
        [self.originalDelegate application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    if ([self.originalDelegate respondsToSelector:@selector(application:performFetchWithCompletionHandler:)])
    {
        [self.originalDelegate application:application performFetchWithCompletionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    if ([self.originalDelegate respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)])
    {
        [self.originalDelegate application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationDidEnterBackground:)])
    {
        [self.originalDelegate applicationDidEnterBackground:application];
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationWillEnterForeground:)])
    {
        [self.originalDelegate applicationWillEnterForeground:application];
    }
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)])
    {
        [self.originalDelegate applicationProtectedDataWillBecomeUnavailable:application];
    }
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
    if ([self.originalDelegate respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)])
    {
        [self.originalDelegate applicationProtectedDataDidBecomeAvailable:application];
    }
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([self.originalDelegate respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)])
    {
        return [self.originalDelegate application:application supportedInterfaceOrientationsForWindow:window];
    }
    
    return 0;
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    if ([self.originalDelegate respondsToSelector:@selector(appl)])
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

- (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder;
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder;
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder;
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder;
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder;

#pragma mark -- User Activity Continuation protocol adopted by UIApplication delegate --

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType;
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray *restorableObjects))restorationHandler;
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error;
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity;
*/

@end
