//
//  FLEXConsolePlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXMenuItem.h"

#import "FLEXConsolePlugin.h"

@implementation FLEXConsolePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.flex.plugin.console"];
    
    if (self)
    {
        FLEXMenuItem* menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.plugin.console.main"];
        menuAction.icon = @"⚠️";
        menuAction.title = @"Console";
        menuAction.viewControllerClass = @"FLEXConsoleTableViewController";
        
        [self registerAction:menuAction];
    }
    
    return self;
}

@end
