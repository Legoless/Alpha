//
//  ALPHAConsolePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAScreenActionItem.h"

#import "ALPHAConsoleSource.h"
#import "ALPHAConsolePlugin.h"

#import "ALPHAConsoleIcon.h"
#import "ALPHAAssetManager.h"

@implementation ALPHAConsolePlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.console"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.console.main"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconConsoleIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Console";
        menuAction.dataIdentifier = ALPHAConsoleDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHAConsoleSource new]];
    }
    
    return self;
}

@end
