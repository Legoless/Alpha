//
//  ALPHAApplicationsListPlugin.m
//  Alpha
//
//  Created by odnairy on 19/07/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAAppsListPlugin.h"

#import "ALPHAScreenActionItem.h"

#import "ALPHAAppsListSource.h"
#import "ALPHAAppsListIcon.h"
#import "ALPHAAssetManager.h"

@implementation ALPHAAppsListPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.odnairy.alpha.plugin.applicationslist"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.odnairy.alpha.plugin.applicationslist.main"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconAppsListIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Applications List";
        menuAction.dataIdentifier = ALPHAAppsListDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHAAppsListSource new]];
    }
    
    return self;
}

@end
