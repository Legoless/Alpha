//
//  ALPHATouchViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 29/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAViewController.h"
#import "ALPHATouchViewController.h"
#import "ALPHAManager.h"

@implementation ALPHATouchViewController

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsStatusBarAppearanceUpdate) name:ALPHAStatusBarUpdateNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [[ALPHAManager defaultManager].alphaWindow.rootViewController preferredStatusBarStyle];
}

@end
