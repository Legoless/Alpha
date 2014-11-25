//
//  FLEXNetworkPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXMenuItem.h"

#import "FLEXNetworkPlugin.h"

@implementation FLEXNetworkPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.flex.plugin.network"];
    
    if (self)
    {
        FLEXMenuItem* menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.plugin.network.main"];
        menuAction.icon = @"💬";
        menuAction.title = @"Network";
        menuAction.viewControllerClass = @"FLEXNetworkTableViewController";
        
        [self registerAction:menuAction];
    }
    
    return self;
}

@end
