//
//  ALPHAGlobalPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAManager.h"
#import "FLEXUtility.h"
#import "ALPHAApplicationDelegate.h"

#import "ALPHAGlobalPlugin.h"
#import "ALPHAActions.h"
#import "ALPHAGlobalCollector.h"
#import "ALPHAClassCollector.h"

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
        
        //menuAction.viewControllerClass = @"FLEXGlobalsTableViewController";
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerCollector:[ALPHAGlobalCollector new]];
        [self registerCollector:[ALPHAClassCollector new]];
    }
    
    return self;
}

@end
