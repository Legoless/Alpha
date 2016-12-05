//
//  ALPHAMotionPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import CoreMotion;

#import "ALPHAMotionPermission.h"

@interface ALPHAMotionPermission ()

@property (nonatomic, strong) CMMotionActivityManager *motionManager;

@end

@implementation ALPHAMotionPermission

#pragma mark - Getters and Setters

- (id)motionUtilities
{
    //
    // This is a private class included in Core Motion framework that has.
    //
    return NSClassFromString(@"CMMotionUtils");
}

- (CMMotionActivityManager *)motionManager
{
    if (!_motionManager)
    {
        _motionManager = [[CMMotionActivityManager alloc] init];
    }
    
    return _motionManager;
}

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.motion"];
}

#pragma mark - Public Methods

- (NSString *)name
{
    return @"Motion";
}

- (ALPHAApplicationAuthorizationStatus)status
{
    if (![CMMotionActivityManager isActivityAvailable])
    {
        return ALPHAApplicationAuthorizationStatusUnsupported;
    }
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    BOOL access = (BOOL)[[self motionUtilities] performSelector:NSSelectorFromString(@"isMotionActivityEntitled")];
    #pragma clang diagnostic pop
    
    return access ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied;
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [[self motionUtilities] performSelector:NSSelectorFromString(@"tccServiceMotionAccess")];
    #pragma clang diagnostic pop
    
    if (completion)
    {
        completion(self, [self status], nil);
    }
    
    /*
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity)
    {
        [motionManager stopActivityUpdates];
        
        if (completion)
        {
            completion(self, ALPHAApplicationAuthorizationStatusAuthorized, nil);
        }
    }];
     */
}

@end
