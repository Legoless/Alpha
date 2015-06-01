//
//  ALPHAStatePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAStatePlugin.h"
#import "ALPHAMenuActionItem.h"
#import "ALPHADeviceStatusCollector.h"

@interface ALPHAStatePlugin ()

@end

@implementation ALPHAStatePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.state"];
    
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
        
        ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.state.status"];
        menuAction.icon = @"📊";
        menuAction.title = @"Status";
        menuAction.dataIdentifier = ALPHADeviceStatusDataIdentifier;
        
        [self registerAction:menuAction];
        
        menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.state.notifications"];
        menuAction.icon = @"🔔";
        menuAction.title = @"Notifications";
        menuAction.viewControllerClass = @"FLEXNotificationTableViewController";
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerCollector:[ALPHADeviceStatusCollector new]];
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
