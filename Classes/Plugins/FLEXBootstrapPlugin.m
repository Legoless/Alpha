//
//  FLEXBootstrapPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXMenuItem.h"

#import "KZBootstrap+FLEXUtilities.h"

#import "FLEXBootstrapPlugin.h"

@implementation FLEXBootstrapPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.flex.plugin.bootstrap"];
    
    if (self)
    {
        if ([KZBootstrap isReady])
        {
            FLEXMenuItem* menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.plugin.bootstrap.main"];
            menuAction.icon = @"🎨";
            menuAction.title = @"Environments";
            menuAction.viewControllerClass = @"FLEXEnvironmentTableViewController";
            
            [self registerAction:menuAction];
        }
    }
    
    return self;
}

@end
