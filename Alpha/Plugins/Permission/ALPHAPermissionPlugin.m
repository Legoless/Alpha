//
//  ALPHAPermissionPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 02/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenActionItem.h"
#import "ALPHAAssetManager.h"
#import "ALPHAPermissionIcon.h"
#import "ALPHAPermissionSource.h"

#import "ALPHAPermissionPlugin.h"

@implementation ALPHAPermissionPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.permission"];
    
    if (self)
    {
        //
        // Menu items
        //
        
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.permission.all"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconPermissionIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Permissions";
        menuAction.dataIdentifier = ALPHAPermissionDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHAPermissionSource new]];
    }
    
    return self;
}

@end
