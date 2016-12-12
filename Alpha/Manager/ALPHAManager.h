//
//  ALPHAManager.h
//  Alpha
//
//  Created by Dal Rupnik on 29/5/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAWindow.h"

#import "ALPHAPlugin.h"
#import "ALPHATheme.h"

#import "ALPHAStatusBarNotification.h"

/*!
 *  Singleton class, main entry point to work with Alpha
 */
@interface ALPHAManager : NSObject

/*!
 *  Alpha main window, that should be always active
 */
@property (nonatomic, readonly) ALPHAWindow* alphaWindow;

/*!
 *  Activates or hides Alpha main interface (default: YES)
 */
@property (nonatomic, getter = isInterfaceHidden) BOOL interfaceHidden;

/*!
 *  Hides or shows entire Alpha view hierarchy
 *
 *  @note: this can cause certain data collectors not to receive correct information
 *  @default: NO
 */
@property (nonatomic, getter = isHidden) BOOL hidden;

/*!
 *  Singleton access to Alpha Manager, main entry point
 *
 *  @return instance of manager
 */
+ (instancetype)defaultManager;

/*!
 *  Integrates Alpha system into the app (called automatically by iOS, do not call)
 */
- (void)integrate;

#pragma mark - Triggers

/*!
 *  Returns currently registered Alpha triggers.
 *  Loop through those to disable them if needed.
 */
@property (nonatomic, readonly) NSArray *triggers;

#pragma mark - Plugins

/*!
 *  Plugin with interface that is activated when Alpha is triggered.
 *  can be changed at any point.
 */
@property (nonatomic, strong) ALPHAPlugin *interfacePlugin;

/*!
 *  Currently registered plugins, as loaded by Alpha at runtime. Loop through those
 *  and disable any you don't need at the moment. Note that interfacePlugin cannot be
 *  disabled.
 */
@property (nonatomic, readonly) NSArray *plugins;

#pragma mark - Theme

/*!
 *  Alpha Interface theme, can be modified to better fit with application
 */
@property (nonatomic, strong) ALPHATheme *theme;

#pragma mark - Windows

/*!
 *  Application main key window
 */
@property (nonatomic, readonly) UIWindow* keyWindow;

/*!
 *  Returns all windows
 *
 *  @return array of UIWindow objects
 */
- (NSArray *)allWindows;

#pragma mark - Modal Presentation of full screen view controllers

/*!
 *  Modally presents new view controller on Alpha window. If running on iPad, this method will wrap the view controller into Split view controller
 *
 *  @param viewController to present
 *  @param animated       if transition is animated
 *  @param completion     called when finished
 */
- (void)displayViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

/*!
 *  Dismisses last modally presented view controller on Alpha window
 *
 *  @param animated   if transition is animated
 *  @param completion called when finished
 */
- (void)removeViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

#pragma mark - Overlay displays

/*!
 *  Adds overlay view controller (child view controller) - use this if view controller is not full-screen.
 *  Uses ChildViewController API
 *
 *  @param viewController controller to overlay
 *  @param animated       if transition is animated
 *  @param completion     called when finished
 */
- (void)addOverlayViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

/*!
 *  Removes overlayed view controllers
 *
 *  @param viewController overlay controller to remove
 */
- (void)removeOverlayViewController:(UIViewController *)viewController;

#pragma mark - Status bar notification display

- (ALPHAStatusBarNotification *)displayNotificationWithMessage:(NSString *)message forDuration:(NSTimeInterval)duration;
- (ALPHAStatusBarNotification *)displayNotificationWithMessage:(NSString *)message completion:(void (^)(void))completion;
- (ALPHAStatusBarNotification *)displayNotificationWithView:(UIView *)view forDuration:(CGFloat)duration;
- (ALPHAStatusBarNotification *)displayNotificationWithView:(UIView *)view completion:(void (^)(void))completion;

@end
