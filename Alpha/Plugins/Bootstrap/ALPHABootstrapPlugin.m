//
//  ALPHABootstrapPlugin.h
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//
#import "ALPHAScreenActionItem.h"

#import "ALPHABootstrap.h"

#import "ALPHAEnvironmentSource.h"

#import "ALPHABootstrapPlugin.h"

#import "ALPHAAssetManager.h"
#import "ALPHAEnvironmentIcon.h"

@implementation ALPHABootstrapPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.bootstrap"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.bootstrap.main"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconEnvironmentIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
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
