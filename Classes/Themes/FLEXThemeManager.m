//
//  FLEXThemeManager.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXThemeManager.h"
#import "FLEXLightTheme.h"
#import "FLEXDarkTheme.h"

@interface FLEXThemeManager ()

@end

@implementation FLEXThemeManager

- (FLEXTheme *)theme
{
    if (!_theme)
    {
        _theme = [[FLEXDarkTheme alloc] init];
    }
    
    return _theme;
}

+ (instancetype)sharedManager
{
    static FLEXThemeManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

@end
