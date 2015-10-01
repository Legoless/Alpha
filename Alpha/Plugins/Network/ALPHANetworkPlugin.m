//
//  ALPHANetworkPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHANetworkSource.h"

#import "ALPHAScreenActionItem.h"

#import "ALPHANetworkPlugin.h"

#import "ALPHANetworkIcon.h"
#import "ALPHAAssetManager.h"

@implementation ALPHANetworkPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.network"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.network.main"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconNetworkIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Network";
        menuAction.dataIdentifier = ALPHANetworkDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHANetworkSource sharedSource]];
    }
    
    return self;
}

@end
