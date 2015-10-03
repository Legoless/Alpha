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

- (NSString *)name
{
    return @"Camera";
}

- (ALPHAApplicationAuthorizationStatus)status
{
    return (ALPHAApplicationAuthorizationStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

@end
