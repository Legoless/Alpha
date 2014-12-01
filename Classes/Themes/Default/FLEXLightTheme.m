//
//  FLEXLightTheme.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXUtility.h"
#import "FLEXLightTheme.h"

@implementation FLEXLightTheme

- (UIColor *)defaultTitleColor
{
    return [UIColor blackColor];
}

- (UIColor *)disabledTitleColor
{
    return [UIColor colorWithWhite:121.0/255.0 alpha:1.0];
}

- (UIColor *)highlightedBackgroundColor
{
    return [UIColor colorWithWhite:0.9 alpha:0.95];
}

- (UIColor *)selectedBackgroundColor
{
    return [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1.0];
}

- (UIColor *)defaultBackgroundColor
{
    return [UIColor colorWithWhite:1.0 alpha:0.95];
}

@end