//
//  ALPHARemotePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"
#import "ALPHABonjourServerSource.h"

#import "ALPHARemotePlugin.h"

@implementation ALPHARemotePlugin

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.remote"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.remote.main"];
        menuAction.icon = @"📶";
        menuAction.title = @"Remote";
        menuAction.dataIdentifier = ALPHABonjourServerDataIdentifier;
        menuAction.isMain = YES;
        menuAction.isRemote = NO;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHABonjourServerSource new]];
    }
    
    return self;
}

@end
