//
//  ALPHAVideoPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import AVFoundation;

#import "ALPHAVideoPermission.h"

@implementation ALPHAVideoPermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.video"];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    return (ALPHAApplicationAuthorizationStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
    {
        if (completion)
        {
            completion (self, (granted) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, nil);
        }
    }];
}

- (NSString *)name
{
    return @"Camera";
}

@end
