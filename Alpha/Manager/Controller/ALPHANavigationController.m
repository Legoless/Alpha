//
//  ALPHANavigationController.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAManager.h"

#import "ALPHANavigationController.h"

@implementation ALPHANavigationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Override status bar style for alpha
    [UIApplication sharedApplication].statusBarStyle = [ALPHAManager defaultManager].theme.statusBarStyle;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [ALPHAManager defaultManager].theme.statusBarStyle;
}

@end
