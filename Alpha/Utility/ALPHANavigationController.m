//
//  ALPHANavigationController.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAManager.h"

#import "ALPHANavigationController.h"

@implementation ALPHANavigationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [ALPHAManager sharedManager].theme.statusBarStyle;
}

@end
