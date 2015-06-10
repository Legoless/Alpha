//
//  ALPHAConsolePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAScreenActionItem.h"

#import "ALPHAConsoleCollector.h"
#import "ALPHAConsolePlugin.h"

@implementation ALPHAConsolePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.console"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.console.main"];
        menuAction.icon = @"⚠️";
        menuAction.title = @"Console";
        menuAction.dataIdentifier = ALPHAConsoleDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHAConsoleCollector new]];
    }
    
    return self;
}

@end
