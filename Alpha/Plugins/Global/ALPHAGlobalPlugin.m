//
//  ALPHAGlobalPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationDelegate.h"

#import "ALPHAGlobalPlugin.h"
#import "ALPHAActions.h"
#import "ALPHAGlobalSource.h"
#import "ALPHAClassSource.h"
#import "ALPHALibrarySource.h"
#import "ALPHAInstanceSource.h"
#import "ALPHAAssetManager.h"
#import "ALPHAGlobalIcon.h"

@implementation ALPHAGlobalPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.global"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.globalState"];
        menuAction.title = @"Global State";
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconGlobalIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.dataIdentifier = ALPHAGlobalDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHAGlobalSource new]];
        [self registerSource:[ALPHAClassSource new]];
        [self registerSource:[ALPHALibrarySource new]];
        [self registerSource:[ALPHAInstanceSource new]];
    }
    
    return self;
}

@end
