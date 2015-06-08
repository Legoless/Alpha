//
//  ALPHAFilePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFilePlugin.h"

@implementation ALPHAFilePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.file"];
    
    if (self)
    {
        /*ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.globalState"];
        menuAction.title = @"Global State";
        menuAction.icon = @"🌍";
        menuAction.dataIdentifier = ALPHAGlobalDataIdentifier;
        menuAction.isMain = YES;
        
        //menuAction.viewControllerClass = @"FLEXGlobalsTableViewController";
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerCollector:[ALPHAGlobalCollector new]];*/
    }
    
    return self;
}

@end
