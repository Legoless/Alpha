//
//  ALPHAConsolePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMenuActionItem.h"

#import "ALPHAConsoleCollector.h"
#import "ALPHAConsolePlugin.h"

@implementation ALPHAConsolePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.console"];
    
    if (self)
    {
        ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.console.main"];
        menuAction.icon = @"⚠️";
        menuAction.title = @"Console";
        menuAction.dataIdentifier = ALPHAConsoleDataIdentifier;
        
        [self registerAction:menuAction];
    }
    
    return self;
}

@end
