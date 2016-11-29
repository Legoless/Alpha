//
//  ALPHAManager.m
//  Alpha
//
//  Created by Dal Rupnik on 29/5/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIApplication+Private.h"

#import "UIApplication+Information.h"

#import "NSObject+Runtime.h"

#import "NSArray+Class.h"

#import "ALPHAManager.h"

// Defaults
#import "ALPHAColorPalette.h"

#import "ALPHAViewController.h"

@interface ALPHAManager () <ALPHAWindowEventDelegate>

/*!
 *  Root view controller that is always active as alphaWindow root
 */
@property (nonatomic, strong, readwrite) ALPHAViewController* rootViewController;

/*!
 *  Alpha window that is placed on top of all windows
 */
@property (nonatomic, strong, readwrite) ALPHAWindow* alphaWindow;

/*!
 *  Main interface view property
 */
@property (nonatomic, readonly) UIView* mainInterfaceView;

#pragma mark - Tracking properties

@property (nonatomic, strong, readwrite) UIWindow* keyWindow;

/// Tracked so we can restore the key window after dismissing a modal.
/// We need to become key after modal presentation so we can correctly capture input.
/// If we're just showing the toolbar, we want the main app's window to remain key so that we don't interfere with input, status bar, etc.
@property (nonatomic, strong) UIWindow *previousKeyWindow;

/// Similar to the previousKeyWindow property above, we need to track status bar styling if
/// the app doesn't use view controller based status bar management. When we present a modal,
/// we want to change the status bar style to UIStausBarStyleDefault. Before changing, we stash
/// the current style. On dismissal, we return the staus bar to the style that the app was using previously.
@property (nonatomic, assign) UIStatusBarStyle previousStatusBarStyle;

#pragma mark - Private properties

@property (nonatomic, strong, readwrite) NSArray *plugins;
@property (nonatomic, strong, readwrite) NSArray *triggers;

@end

@implementation ALPHAManager

@synthesize interfacePlugin = _interfacePlugin;
@synthesize theme = _theme;

#pragma mark - Getters and Setters

- (ALPHAPlugin *)interfacePlugin
{
    if (!_interfacePlugin)
    {
        _interfacePlugin = [self.plugins alpha_firstObjectOfClass:NSClassFromString(@"ALPHAInterfacePlugin")];
        [self addOverlayViewController:_interfacePlugin.mainInterface animated:NO completion:nil];
    }
    
    return _interfacePlugin;
}

- (void)setInterfacePlugin:(ALPHAPlugin *)interfacePlugin
{
    //
    // If we have base plugin set (which is usually the case), need to clean up, to support
    // using any base plugin.
    //
    if (_interfacePlugin)
    {
        [self removeOverlayViewController:_interfacePlugin.mainInterface];
    }
    
    _interfacePlugin = interfacePlugin;
    _interfacePlugin.enabled = YES;
    
    [self addOverlayViewController:_interfacePlugin.mainInterface animated:NO completion:nil];
}

- (ALPHAViewController *)rootViewController
{
    if (!_rootViewController)
    {
        _rootViewController = [[ALPHAViewController alloc] init];
    }
    
    return _rootViewController;
}

- (ALPHAWindow *)alphaWindow
{
    NSAssert([NSThread isMainThread], @"You must use %@ from the main thread only.", NSStringFromClass([self class]));
    
    if (!_alphaWindow)
    {
        if (!self.keyWindow)
        {
            self.keyWindow = [[UIApplication sharedApplication] keyWindow];
        }
        
        _alphaWindow = [[ALPHAWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _alphaWindow.eventDelegate = self;
        _alphaWindow.rootViewController = self.rootViewController;
        _alphaWindow.hidden = NO;
    }
    
    return _alphaWindow;
}

- (UIView *)mainInterfaceView
{
    return self.interfacePlugin.mainInterface.view;
}

- (UIWindow *)keyWindow
{
    if (!_keyWindow)
    {
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    
    return _keyWindow;
}

#pragma mark - Singleton

+ (instancetype)defaultManager
{
    static ALPHAManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

#pragma mark - Theme

- (ALPHATheme *)theme
{
    if (!_theme)
    {
        _theme = [ALPHAColorPalette defaultPalette].paletteTheme;
        [_theme applyInWindow:self.alphaWindow];
    }
    
    return _theme;
}

- (void)setTheme:(ALPHATheme *)theme
{
    _theme = theme;
    [_theme applyInWindow:self.alphaWindow];
}

#pragma mark - Display

- (BOOL)isHidden
{
    return self.alphaWindow.isHidden;
}

- (void)setHidden:(BOOL)hidden
{
    self.alphaWindow.hidden = hidden;
}

- (BOOL)isInterfaceHidden
{
    return self.mainInterfaceView.isHidden;
}

- (void)setInterfaceHidden:(BOOL)interfaceHidden
{
    self.mainInterfaceView.hidden = interfaceHidden;
}

#pragma mark - ALPHAManager

- (instancetype)init
{
    self = [super init];
    
    //
    // If we are running tests, we'll just return nil here, to disable all Alpha functionality
    // and speed up loading time.
    //
    if ([[UIApplication sharedApplication] alpha_isRunningTests])
    {
        return nil;
    }
    
    return self;
}

/*!
 *  Generally this will only be called once, since plugins and triggers cannot be
 *  loaded at runtime. The concept here is that all each plugin and trigger is created
 *  for the first time on start in a singleton pattern, even if the functionality is not
 *  available (or disabled later).
 *
 *  Inactive triggers or plugins do not use any resources or modify any data,
 *  except for few bytes of data that keeps base objects in memory.
 */
- (void)integrate
{
    //
    // Protect against multiple initialization
    //
    if (self.plugins.count || self.triggers.count)
    {
        return;
    }
    
    self.plugins = [self createInstancesOfClass:NSClassFromString(@"ALPHAPlugin")];
    self.triggers = [self createInstancesOfClass:NSClassFromString(@"ALPHATrigger")];
}

- (NSArray *)createInstancesOfClass:(Class)class
{
    NSArray *subclasses = [class alpha_subclasses];
    NSMutableArray* instances = [NSMutableArray array];
    
    for (Class class in subclasses)
    {
        id object = [[class alloc] init];
        
        //
        // Plugins need to have an identifier of length to be supported
        //
        
        if ([object respondsToSelector:@selector(identifier)])
        {
            if ([[object identifier] length] > 0)
            {
                [instances addObject:object];
            }
        }
        else
        {
            [instances addObject:object];
        }
    }
    
    return [instances copy];
}

#pragma mark - ALPHAWindowEventDelegate

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    //
    // Should go through all plugins and ask them all if they should
    // receive touches. If at least one says YES, we will redirect input
    // to the plugin.
    //
    
    NSArray* plugins = self.plugins;
    
    for (ALPHAPlugin* plugin in plugins)
    {
        if (plugin.isEnabled)
        {
            BOOL willHandle = [plugin shouldHandleTouchAtPoint:pointInWindow];
            
            if (willHandle)
            {
                return YES;
            }
        }
    }
    
    return NO;
}

#pragma mark - Windows

- (NSArray *)allWindows
{
    NSMutableArray *windows = [[[UIApplication sharedApplication] windows] mutableCopy];
    UIWindow *statusWindow = [[UIApplication sharedApplication] alpha_statusWindow];
    if (statusWindow) {
        // The windows are ordered back to front, so default to inserting the status bar at the end.
        // However, it there are windows at status bar level, insert the status bar before them.
        NSInteger insertionIndex = [windows count];
        for (UIWindow *window in windows)
        {
            if (window.windowLevel >= UIWindowLevelStatusBar)
            {
                insertionIndex = [windows indexOfObject:window];
                break;
            }
        }
        [windows insertObject:statusWindow atIndex:insertionIndex];
    }
    return windows;
}
   
#pragma mark - UIStatusBar

#pragma mark - Modal Presentation and Window Management

- (void)addOverlayViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    viewController.view.frame = self.alphaWindow.bounds;
    [self.rootViewController.view addSubview:viewController.view];
    
    [self.rootViewController addChildViewController:viewController];
    
    [viewController didMoveToParentViewController:self.rootViewController];
    
    //
    // Make sure Base plugin is on top so we have the ability to
    // cancel other plugins.
    //
    
    [self.rootViewController.view bringSubviewToFront:self.mainInterfaceView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAStatusBarUpdateNotification object:nil];
    
    if (completion)
    {
        completion();
    }
}

- (void)removeOverlayViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAStatusBarUpdateNotification object:nil];
}

- (void)displayViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    // Save the current key window so we can restore it following dismissal.
    self.previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
    
    // Make our window key to correctly handle input.
    [self.rootViewController.view.window makeKeyWindow];
    
    // Move the status bar on top of window so we can get scroll to top behavior for taps.
    [[[UIApplication sharedApplication] alpha_statusWindow] setWindowLevel:self.rootViewController.view.window.windowLevel + 1.0];
    
    // If this app doesn't use view controller based status bar management and we're on iOS 7+,
    // make sure the status bar style is UIStatusBarStyleDefault. We don't actually have to check
    // for view controller based management because the global methods no-op if that is turned on.
    self.previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:self.theme.statusBarStyle animated:animated];
    
    // Show the view controller.
    [self.rootViewController presentViewController:viewController animated:animated completion:completion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAStatusBarUpdateNotification object:nil];
}

- (void)removeViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self.previousKeyWindow makeKeyWindow];
    
    self.previousKeyWindow = nil;
    
    // Restore the status bar window's normal window level.
    // We want it above the window, while a modal is presented for scroll to top, but below otherwise for exploration.
    [[[UIApplication sharedApplication] alpha_statusWindow] setWindowLevel:UIWindowLevelStatusBar];
    
    // Restore the stauts bar style if the app is using global status bar management.
    // Only for iOS 7+
    [[UIApplication sharedApplication] setStatusBarStyle:self.previousStatusBarStyle animated:animated];
    
    [self.rootViewController dismissViewControllerAnimated:animated completion:completion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAStatusBarUpdateNotification object:nil];
}


#pragma mark - Helper methods

- (ALPHAPlugin *)enabledPluginOfClass:(Class)class
{
    for (ALPHAPlugin* plugin in self.plugins)
    {
        if ([plugin isKindOfClass:class] && plugin.isEnabled)
        {
            return plugin;
        }
    }
    
    return nil;
}

#pragma mark - Notifications

- (ALPHAStatusBarNotification *)displayNotificationWithMessage:(NSString *)message forDuration:(NSTimeInterval)duration
{
    ALPHAStatusBarNotification *notification = [[ALPHAStatusBarNotification alloc] init];
    
    [notification displayNotificationWithMessage:message forDuration:duration];
    
    [self applyTheme:self.theme toNotification:notification];
    
    return notification;
}

- (ALPHAStatusBarNotification *)displayNotificationWithMessage:(NSString *)message completion:(void (^)(void))completion
{
    ALPHAStatusBarNotification *notification = [[ALPHAStatusBarNotification alloc] init];
    
    [notification displayNotificationWithMessage:message completion:completion];
    
    [self applyTheme:self.theme toNotification:notification];
    
    return notification;
}

- (ALPHAStatusBarNotification *)displayNotificationWithView:(UIView *)view forDuration:(CGFloat)duration
{
    ALPHAStatusBarNotification *notification = [[ALPHAStatusBarNotification alloc] init];
    
    [notification displayNotificationWithView:view forDuration:duration];
    
    [self applyTheme:self.theme toNotification:notification];
    
    return notification;
}

- (ALPHAStatusBarNotification *)displayNotificationWithView:(UIView *)view completion:(void (^)(void))completion
{
    ALPHAStatusBarNotification *notification = [[ALPHAStatusBarNotification alloc] init];
    
    [notification displayNotificationWithView:view completion:completion];
    
    [self applyTheme:self.theme toNotification:notification];
    
    return notification;
}

- (void)applyTheme:(ALPHATheme *)theme toNotification:(ALPHAStatusBarNotification *)notification
{
    notification.notificationLabel.font = theme.notificationFont;
    notification.notificationLabel.backgroundColor = theme.notificationBackgroundColor;
    notification.notificationLabel.textColor = theme.notificationTintColor;
}

@end
