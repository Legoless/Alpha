//
//  ALPHAGlobalPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationDelegate.h"

#import "ALPHAGlobalPlugin.h"
#import "ALPHAActions.h"
#import "ALPHAGlobalSource.h"
#import "ALPHAClassSource.h"
#import "ALPHALibrarySource.h"

@implementation ALPHAGlobalPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.global"];
    
    if (self)
    {
        ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.globalState"];
        menuAction.title = @"Global State";
        menuAction.icon = @"🌍";
        menuAction.dataIdentifier = ALPHAGlobalDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHAGlobalSource new]];
        [self registerSource:[ALPHAClassSource new]];
        [self registerSource:[ALPHALibrarySource new]];
    }
    
    return self;
}

@end
