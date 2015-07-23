//
//  ALPHAApplicationsListPlugin.m
//  Alpha
//
//  Created by odnairy on 19/07/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationPlugin.h"

#import "ALPHAScreenActionItem.h"

#import "ALPHAApplicationSource.h"
#import "ALPHAApplicationIcon.h"
#import "ALPHAAssetManager.h"

@implementation ALPHAApplicationPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.odnairy.alpha.plugin.application"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.odnairy.alpha.plugin.applicationslist.main"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconAppsListIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Applications";
        menuAction.dataIdentifier = ALPHAApplicationDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHAApplicationSource new]];
    }
    
    return self;
}

@end
