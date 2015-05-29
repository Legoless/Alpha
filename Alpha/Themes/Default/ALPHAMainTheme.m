//
//  ALPHAMainTheme.m
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMainTheme.h"

@implementation ALPHAMainTheme

- (UIColor *)tintColor
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
