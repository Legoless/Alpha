//
//  ALPHALocationPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import CoreLocation;

#import "ALPHARuntimeUtility.h"

#import "ALPHALocationPermission.h"

@interface ALPHALocationPermission () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ALPHAPermissionRequestCompletion completionBlock;

@end

@implementation ALPHALocationPermission

#pragma mark - Getters and Setters

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

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

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    self.completionBlock = completion;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (NSString *)statusString
{
    return [self stringForLocationPermissionStatus:[CLLocationManager authorizationStatus]];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [manager stopUpdatingLocation];
    
    if (self.completionBlock)
    {
        self.completionBlock (self, [self statusForLocationStatus:status], nil);
        self.completionBlock = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [manager stopUpdatingLocation];
    
    if (self.completionBlock)
    {
        self.completionBlock (self, [self status], nil);
        self.completionBlock = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    
    if (self.completionBlock)
    {
        self.completionBlock (self, [self status], error);
        self.completionBlock = nil;
    }
}

#pragma mark - Private Methods

- (ALPHAApplicationAuthorizationStatus)statusForLocationStatus:(CLAuthorizationStatus)status
{
    switch (status)
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
