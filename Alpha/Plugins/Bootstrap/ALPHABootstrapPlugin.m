//
//  ALPHABootstrapPlugin.h
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//
#import "ALPHAScreenActionItem.h"

#import "ALPHABootstrap.h"

#import "ALPHAEnvironmentSource.h"

#import "ALPHABootstrapPlugin.h"

@implementation ALPHABootstrapPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.bootstrap"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.bootstrap.main"];
        menuAction.icon = @"🎨";
        menuAction.title = @"Environments";
        menuAction.dataIdentifier = ALPHAEnvironmentDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        if ([ALPHABootstrap hasEnvironments])
        {
            [self registerSource:[ALPHAEnvironmentSource new]];
        }
    }
    
    return self;
}

@end
