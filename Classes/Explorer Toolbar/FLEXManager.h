//
//  FLEXManager.h
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXWindow.h"

#import "FLEXPlugin.h"

@interface FLEXManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, getter = isHidden) BOOL hidden;

@property (nonatomic, readonly) UIWindow* keyWindow;

@property (nonatomic, readonly) UIViewController* rootViewController;

/**
 *  Returns all windows
 *
 *  @return array of UIWindow objects
 */
- (NSArray *)allWindows;

#pragma mark - Modal Presentation and Window Management

- (void)makeKeyAndPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)resignKeyAndDismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)addChildViewControllerToRootViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)removeChildViewController:(UIViewController *)viewController;

#pragma mark - Extensions

//- (void)registerPlugin:(FLEXPlugin *)plugin;

@end
