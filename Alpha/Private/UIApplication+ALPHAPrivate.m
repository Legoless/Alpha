//
//  UIApplication+ALPHAPrivate.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "UIApplication+ALPHAPrivate.h"

@implementation UIApplication (ALPHAPrivate)

- (UIWindow *)statusWindow
{
    NSString *statusBarString = [NSString stringWithFormat:@"%@arWindow", @"_statusB"];
    return [self valueForKey:statusBarString];
}

- (UIView *)statusBar
{
    NSString *statusBarString = [NSString stringWithFormat:@"%@ar", @"_statusB"];
    return [self valueForKey:statusBarString];
}

@end
