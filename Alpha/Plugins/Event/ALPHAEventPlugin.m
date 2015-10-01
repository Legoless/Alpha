//
//  ALPHAEventPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEventPlugin.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHAEventSource.h"
#import "ALPHAAssetManager.h"
#import "ALPHAEventIcon.h"

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
        
        ALPHAScreenActionItem *menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.event.events"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconEventIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Events";
        menuAction.dataIdentifier = ALPHAEventDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHAEventSource sharedSource]];
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
