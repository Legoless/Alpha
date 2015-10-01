//
//  ALPHAStatePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAStatePlugin.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHADeviceStatusSource.h"
#import "ALPHAAssetManager.h"
#import "ALPHAStatusIcon.h"

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
        
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.state.status"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconStatusIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Status";
        menuAction.dataIdentifier = ALPHADeviceStatusDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHADeviceStatusSource new]];
    }
    
    return self;
}

@end
