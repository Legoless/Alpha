//
//  ALPHAMobileDataPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMobileDataPermission.h"

@implementation ALPHAMobileDataPermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.mobiledata"];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    return ALPHAApplicationAuthorizationStatusNotDetermined;
}

@end
