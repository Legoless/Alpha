//
//  ALPHAAssetPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import AssetsLibrary;

#import "ALPHAAssetPermission.h"

@implementation ALPHAAssetPermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.asset"];
}

#pragma mark - Public Methods

- (NSString *)name
{
    return @"Photos";
}

- (ALPHAApplicationAuthorizationStatus)status
{
    return (ALPHAApplicationAuthorizationStatus)[ALAssetsLibrary authorizationStatus];
}

@end
