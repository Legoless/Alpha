//
//  ALPHAEventPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEventPlugin.h"
#import "ALPHAMenuActionItem.h"

@implementation ALPHAEventPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.event"];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationSignificantTimeChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationNotification:) name:UIApplicationBackgroundRefreshStatusDidChangeNotification object:nil];
        
        //
        // Menu items
        //
        
        ALPHAMenuActionItem *menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.event.events"];
        menuAction.icon = @"📅";
        menuAction.title = @"Events";
        //menuAction.viewControllerClass = @"FLEXNotificationTableViewController";
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        //[self registerCollector:[ALPHADeviceStatusCollector new]];
    }
    
    return self;
}

- (void)dealloc
{
    //
    // Cleaning up the house
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleApplicationNotification:(NSNotification *)notification
{
    if (!self.isEnabled)
    {
        return;
    }
}


@end
