//
//  ALPHALocationPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import CoreLocation;

#import "ALPHALocationPermission.h"

@implementation ALPHALocationPermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.location"];
}

#pragma mark - Public methods

- (ALPHAApplicationAuthorizationStatus)status
{
    switch ([CLLocationManager authorizationStatus])
    {
        case kCLAuthorizationStatusNotDetermined:
            return ALPHAApplicationAuthorizationStatusNotDetermined;
        case kCLAuthorizationStatusRestricted:
            return ALPHAApplicationAuthorizationStatusRestricted;
        case kCLAuthorizationStatusDenied:
            return ALPHAApplicationAuthorizationStatusDenied;
        default:
            return ALPHAApplicationAuthorizationStatusAuthorized;
    }
}

- (NSString *)statusString
{
    return [self stringForLocationPermissionStatus:[CLLocationManager authorizationStatus]];
}

#pragma mark - Private Methods

- (NSString *)stringForLocationPermissionStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusNotDetermined);
        case kCLAuthorizationStatusRestricted:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusRestricted);
        case kCLAuthorizationStatusDenied:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusDenied);
        case kCLAuthorizationStatusAuthorizedAlways:
            return @"Authorized Always";
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return @"When in Use";
        default:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusAuthorized);
    }
}
@end
