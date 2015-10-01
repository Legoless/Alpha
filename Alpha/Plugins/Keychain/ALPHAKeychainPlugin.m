//
//  ALPHAKeychainPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 01/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenActionItem.h"

#import "ALPHAKeychainPlugin.h"

#import "ALPHAKeychainIcon.h"
#import "ALPHAKeychainSource.h"

#import "ALPHAAssetManager.h"

@implementation ALPHAKeychainPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.keychain"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.keychain"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconKeychainIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Keychain";
        menuAction.dataIdentifier = ALPHAKeychainDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHAKeychainSource new]];
    }
    
    return self;
}

@end
