//
//  UIApplication+Private.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIApplication+Private.h"

@implementation UIApplication (Private)

- (UIWindow *)alpha_statusWindow
{
    NSString *statusBarString = [NSString stringWithFormat:@"%@arWindow", @"_statusB"];
    return [self valueForKey:statusBarString];
}

- (UIView *)alpha_statusBar
{
    NSString *statusBarString = [NSString stringWithFormat:@"%@ar", @"_statusB"];
    return [self valueForKey:statusBarString];
}

@end
