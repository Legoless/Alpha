//
//  FLEXManager.m
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXManager.h"
#import "FLEXWindow.h"

#import "FLEXPluginManager.h"

#import "FLEXObjectExplorerFactory.h"
#import "FLEXObjectExplorerViewController.h"

#import "FLEXBasePlugin.h"

#import "FLEXViewController.h"

@interface FLEXManager () <FLEXWindowEventDelegate>

@property (nonatomic, strong, readwrite) FLEXViewController* rootViewController;

@property (nonatomic, strong) FLEXWindow *explorerWindow;

@property (nonatomic, strong, readwrite) UIWindow* keyWindow;


/// Tracked so we can restore the key window after dismissing a modal.
/// We need to become key after modal presentation so we can correctly capture intput.
/// If we're just showing the toolbar, we want the main app's window to remain key so that we don't interfere with input, status bar, etc.
@property (nonatomic, strong) UIWindow *previousKeyWindow;

/// Similar to the previousKeyWindow property above, we need to track status bar styling if
/// the app doesn't use view controller based status bar management. When we present a modal,
/// we want to change the status bar style to UIStausBarStyleDefault. Before changing, we stash
/// the current style. On dismissal, we return the staus bar to the style that the app was using previously.
@property (nonatomic, assign) UIStatusBarStyle previousStatusBarStyle;

@end

@implementation FLEXManager


- (UIViewController *)rootViewController
{
    if (!_rootViewController)
    {
        _rootViewController = [[FLEXViewController alloc] init];
    }
    
    return _rootViewController;
}

- (UIWindow *)keyWindow
{
    if (!_keyWindow)
    {
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    
    return _keyWindow;
}

+ (instancetype)sharedManager
{
    static FLEXManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        //
        // Add base plugin's interface to root view controller
        //
        [self addChildViewControllerToRootViewController:[[FLEXPluginManager sharedManager] basePlugin].mainInterface animated:NO completion:nil];
    }
    
    return self;
}

- (FLEXWindow *)explorerWindow
{
    NSAssert([NSThread isMainThread], @"You must use %@ from the main thread only.", NSStringFromClass([self class]));
    
    if (!_explorerWindow)
    {
        if (!self.keyWindow)
        {
            self.keyWindow = [[UIApplication sharedApplication] keyWindow];
        }
        
        _explorerWindow = [[FLEXWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _explorerWindow.eventDelegate = self;
        _explorerWindow.rootViewController = self.rootViewController;
    }
    
    return _explorerWindow;
}

- (void)showExplorer
{
    self.explorerWindow.hidden = NO;
}

- (void)hideExplorer
{
    self.explorerWindow.hidden = YES;
}

- (BOOL)isHidden
{
    return self.explorerWindow.isHidden;
}

- (void)setHidden:(BOOL)hidden
{
    self.explorerWindow.hidden = hidden;
}


#pragma mark - FLEXWindowEventDelegate

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    //
    // Should go through all plugins and ask them all if they should
    // receive touches. If at least one says YES, we will redirect input
    // to the plugin.
    //
    
    NSArray* plugins = [FLEXPluginManager sharedManager].plugins;
    
    for (FLEXPlugin* plugin in plugins)
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

#pragma mark - Extensions

/*
- (void)registerGlobalEntryWithName:(NSString *)entryName objectFutureBlock:(id (^)(void))objectFutureBlock
{
    NSParameterAssert(entryName);
    NSParameterAssert(objectFutureBlock);
    NSAssert([NSThread isMainThread], @"This method must be called from the main thread.");

    entryName = entryName.copy;
    FLEXGlobalsTableViewControllerEntry *entry = [FLEXGlobalsTableViewControllerEntry entryWithNameFuture:^NSString *{
        return entryName;
    } viewControllerFuture:^UIViewController *{
        return [FLEXObjectExplorerFactory explorerViewControllerForObject:objectFutureBlock()];
    }];

    //[self.userGlobalEntries addObject:entry];
}*/

#pragma mark - Status bar

- (UIWindow *)statusWindow
{
    NSString *statusBarString = [NSString stringWithFormat:@"%@arWindow", @"_statusB"];
    return [[UIApplication sharedApplication] valueForKey:statusBarString];
}


- (NSArray *)allWindows
{
    NSMutableArray *windows = [[[UIApplication sharedApplication] windows] mutableCopy];
    UIWindow *statusWindow = [self statusWindow];
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



#pragma mark - Modal Presentation and Window Management

- (void)addChildViewControllerToRootViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    viewController.view.frame = self.explorerWindow.bounds;
    [self.rootViewController.view addSubview:viewController.view];
    
    [self.rootViewController addChildViewController:viewController];
    
    [viewController didMoveToParentViewController:self.rootViewController];
    
    //
    // Make sure Base plugin is on top so we have the ability to
    // cancel other plugins.
    //
    
    [self.rootViewController.view bringSubviewToFront:[FLEXPluginManager sharedManager].basePlugin.mainInterface.view];
    
    if (completion)
    {
        completion();
    }
}

- (void)removeChildViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)makeKeyAndPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    // Save the current key window so we can restore it following dismissal.
    self.previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
    
    // Make our window key to correctly handle input.
    [self.rootViewController.view.window makeKeyWindow];
    
    // Move the status bar on top of FLEX so we can get scroll to top behavior for taps.
    [[self statusWindow] setWindowLevel:self.rootViewController.view.window.windowLevel + 1.0];
    
    // If this app doesn't use view controller based status bar management and we're on iOS 7+,
    // make sure the status bar style is UIStatusBarStyleDefault. We don't actully have to check
    // for view controller based management because the global methods no-op if that is turned on.
    // Only for iOS 7+
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        self.previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    // Show the view controller.
    [self.rootViewController presentViewController:viewController animated:animated completion:completion];
}

- (void)resignKeyAndDismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self.previousKeyWindow makeKeyWindow];
    
    self.previousKeyWindow = nil;
    
    // Restore the status bar window's normal window level.
    // We want it above FLEX while a modal is presented for scroll to top, but below FLEX otherwise for exploration.
    [[self statusWindow] setWindowLevel:UIWindowLevelStatusBar];
    
    // Restore the stauts bar style if the app is using global status bar management.
    // Only for iOS 7+
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:self.previousStatusBarStyle];
    }
    
    [self.rootViewController dismissViewControllerAnimated:animated completion:completion];
}


@end
