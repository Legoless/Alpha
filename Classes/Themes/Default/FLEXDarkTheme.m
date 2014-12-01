//
//  FLEXDarkTheme.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXDarkTheme.h"

@implementation FLEXDarkTheme

- (UIColor *)defaultTitleColor
{
    return [UIColor whiteColor];
}

- (UIColor *)disabledTitleColor
{
    return [UIColor colorWithWhite:0.8 alpha:1.0];
}

- (UIColor *)highlightedBackgroundColor
{
    return [UIColor colorWithWhite:0.4 alpha:1.0];
}

- (UIColor *)selectedBackgroundColor
{
    return [UIColor colorWithWhite:0.6 alpha:1.0];
}

- (UIColor *)defaultBackgroundColor
{
    return [UIColor colorWithWhite:0.0 alpha:0.8];
}

@end