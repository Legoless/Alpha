//
//  FLEXNetworkPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "ALPHAMenuActionItem.h"

#import "FLEXNetworkPlugin.h"

@implementation FLEXNetworkPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.network"];
    
    if (self)
    {
        ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.network.main"];
        menuAction.icon = @"💬";
        menuAction.title = @"Network";
        menuAction.viewControllerClass = @"FLEXNetworkTableViewController";
        
        [self registerAction:menuAction];
    }
    
    return self;
}

@end
