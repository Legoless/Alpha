//
//  FLEXStatePlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXStatePlugin.h"
#import "FLEXMenuItem.h"
#import "FLEXApplicationDelegate.h"

@interface FLEXStatePlugin ()

@property (nonatomic, strong) FLEXApplicationDelegate* appDelegate;

@end

@implementation FLEXStatePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.flex.plugin.state"];
    
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
        // Set application delegate, so we can track notifications
        //
        
        self.appDelegate = [[FLEXApplicationDelegate alloc] init];
        
        self.appDelegate.originalDelegate = [UIApplication sharedApplication].delegate;
        
        [UIApplication sharedApplication].delegate = self.appDelegate;
        
        //
        // Menu items
        //
        
        FLEXMenuItem* menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.plugin.state.status"];
        menuAction.icon = @"📊";
        menuAction.title = @"Status";
        menuAction.viewControllerClass = @"FLEXStatusTableViewController";
        
        [self registerAction:menuAction];
        
        menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.plugin.state.notifications"];
        menuAction.icon = @"🔔";
        menuAction.title = @"Notifications";
        menuAction.viewControllerClass = @"FLEXNotificationTableViewController";
        
        [self registerAction:menuAction];
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
