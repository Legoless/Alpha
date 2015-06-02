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
        //
        // Menu items
        //
        
        ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.state.status"];
        menuAction.icon = @"📊";
        menuAction.title = @"Status";
        menuAction.dataIdentifier = ALPHADeviceStatusDataIdentifier;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerCollector:[ALPHADeviceStatusCollector new]];
    }
    
    return self;
}

@end
