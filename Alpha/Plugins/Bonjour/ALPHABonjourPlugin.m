//
//  ALPHABonjourPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//


#import "ALPHABonjourPlugin.h"

#import "ALPHAActions.h"

#import "ALPHABonjourConfig.h"

#import "ALPHALocalSource.h"

#import "ALPHABonjourServer.h"

#import "ALPHACoreAssets.h"

@interface ALPHABonjourPlugin ()

@property (nonatomic, strong) ALPHABonjourServer* server;

@end

@implementation ALPHABonjourPlugin

#pragma mark - Getters and Setters

- (ALPHABonjourServer *)server
{
    if (!_server)
    {
        _server = [[ALPHABonjourServer alloc] init];
        _server.source = [ALPHALocalSource new];
    }
    
    return _server;
}

#pragma mark - Initialization

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.bonjour"];
    
    if (self)
    {
        ALPHABlockActionItem *touchAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.bonjour.activate"];
        touchAction.title = @"Bonjour";
        touchAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconRemoteIdentifier];
        touchAction.actionBlock = ^id(id sender)
        {
            [self activateBonjourServer];
            
            return nil;
        };
        
        [self registerAction:touchAction];
                
        //[self registerSource:[ALPHAScreenshotSource new]];
    }
    
    return self;
}

- (void)activateBonjourServer
{
    if (self.server.isActive)
    {
        [self.server stop];
    }
    else
    {
        [self.server start];
    }
}

@end
