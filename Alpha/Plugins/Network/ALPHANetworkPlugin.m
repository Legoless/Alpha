//
//  ALPHANetworkPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHANetworkCollector.h"

#import "ALPHAMenuActionItem.h"

#import "ALPHANetworkPlugin.h"

@implementation ALPHANetworkPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.network"];
    
    if (self)
    {
        ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.network.main"];
        menuAction.icon = @"💬";
        menuAction.title = @"Network";
        menuAction.dataIdentifier = ALPHANetworkDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHANetworkCollector sharedCollector]];
    }
    
    return self;
}

@end
