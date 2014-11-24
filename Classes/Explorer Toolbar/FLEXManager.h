//
//  FLEXManager.h
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEXPlugin.h"

@interface FLEXManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, getter = isHidden) BOOL hidden;

@property (nonatomic, readonly) UIWindow* keyWindow;

#pragma mark - Deprecated

- (void)showExplorer;
- (void)hideExplorer;

#pragma mark - Extensions

- (void)registerPlugin:(FLEXPlugin *)plugin;

@end
