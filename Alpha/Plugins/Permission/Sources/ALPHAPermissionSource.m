//
//  ALPHAPermissionSource.m
//  Alpha
//
//  Created by Dal Rupnik on 02/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import AssetsLibrary;
@import AVFoundation;
@import Contacts;
@import CoreLocation;
@import CoreMotion;
@import EventKit;
@import HealthKit;


#import "ALPHAUtility.h"

#import "ALPHAPermissionSource.h"

#import "ALPHAModel.h"
#import "ALPHATableScreenModel.h"

NSString* const ALPHAPermissionDataIdentifier = @"com.unifiedsense.alpha.data.permission";

#pragma mark - Permission Convenience Methods

typedef enum : NSUInteger {
    ALPHAApplicationAuthorizationStatusNotDetermined,
    ALPHAApplicationAuthorizationStatusRestricted,
    ALPHAApplicationAuthorizationStatusDenied,
    ALPHAApplicationAuthorizationStatusAuthorized,
    ALPHAApplicationAuthorizationStatusUnsupported,
    ALPHAApplicationAuthorizationStatusAskAgain,
    ALPHAApplicationAuthorizationStatusDoNotAskAgain,
} ALPHAApplicationAuthorizationStatus;

NSString* NSStringFromAuthorizationStatus (ALPHAApplicationAuthorizationStatus status)
{
    switch (status)
    {
        case ALPHAApplicationAuthorizationStatusNotDetermined:
            return @"Not Determined";
        case ALPHAApplicationAuthorizationStatusRestricted:
            return @"Restricted";
        case ALPHAApplicationAuthorizationStatusDenied:
            return @"Denied";
        case ALPHAApplicationAuthorizationStatusAuthorized:
            return @"Authorized";
        case ALPHAApplicationAuthorizationStatusUnsupported:
            return @"Unsupported";
        case ALPHAApplicationAuthorizationStatusAskAgain:
            return @"Ask Again";
        case ALPHAApplicationAuthorizationStatusDoNotAskAgain:
            return @"Do Not Ask Again";

    }
}

#pragma mark - Permission Source

@interface ALPHAPermissionSource ()

@end

@implementation ALPHAPermissionSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAPermissionDataIdentifier];
        
        [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    //
    // TODO: Add Notifications and healthkit permissions
    //
    
    CLAuthorizationStatus systemState = [CLLocationManager authorizationStatus];
    
    //CBCentralManager* testBluetooth = [[CBCentralManager alloc] initWithDelegate:nil queue: nil];
    
    NSDictionary* sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.permission.list",
                     @"items" : @[
                             //@{ @"Bluetooth" : ALPHAEncodeBool([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) },
                             @{ @"Calendar" : NSStringFromAuthorizationStatus((ALPHAApplicationAuthorizationStatus)[EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) },
                             @{ @"Camera" : NSStringFromAuthorizationStatus((ALPHAApplicationAuthorizationStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) },
                             @{ @"Contacts" : NSStringFromAuthorizationStatus((ALPHAApplicationAuthorizationStatus)[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) },
                             //@{ @"HomeKit" : ALPHAEncodeBool([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) },
                             @{ @"Location" : [self stringForLocationPermissionStatus:[CLLocationManager authorizationStatus]] },
                             //@{ @"Mobile Data" : [[NSBundle mainBundle] bundleIdentifier] },
                             //@{ @"Motion Activity" : [CMMotionActivityManager isActivityAvailable] },
                             @{ @"Microphone" : [self stringForRecordPermissionStatus:[AVAudioSession sharedInstance].recordPermission] },
                             @{ @"Photos" : NSStringFromAuthorizationStatus((ALPHAApplicationAuthorizationStatus)[ALAssetsLibrary authorizationStatus]) },
                             @{ @"Reminders" : NSStringFromAuthorizationStatus((ALPHAApplicationAuthorizationStatus)[EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) }
                             ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"Notifications" };
    
    ALPHAScreenSection* permissionSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    
    //
    // Data model
    //
    
    ALPHATableScreenModel* dataModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAPermissionDataIdentifier];
    dataModel.title = @"Permissions";
    dataModel.tableViewStyle = UITableViewStyleGrouped;
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:permissionSection];
    
    [array addObject:[self notificationSection]];
    
    ALPHAScreenSection *healthSection = [self healthSection];
    
    if (healthSection)
    {
        [array addObject:healthSection];
    }
    
    dataModel.sections = array.copy;
    
    return dataModel;
}

#pragma mark - Private Methods

/*!
 *  Most of those methods are added because the indexes of statuses do not match the correct enums defined above,
 *  or they have specific permissions such as location: "When in Use".
 */

- (NSString *)stringForRecordPermissionStatus:(AVAudioSessionRecordPermission)permission
{
    switch (permission)
    {
        case AVAudioSessionRecordPermissionUndetermined:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusNotDetermined);
        case AVAudioSessionRecordPermissionDenied:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusDenied);
        case AVAudioSessionRecordPermissionGranted:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusAuthorized);
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


- (ALPHAScreenSection *)healthSection
{
    NSMutableArray *items = [NSMutableArray array];
    
    /*
    NSMutableSet *allTypes = [NSMutableSet set];
    
    if (self.objectTypesRead.count) {
        [allTypes unionSet:self.objectTypesRead];
    }
    
    if (self.objectTypesWrite.count) {
        [allTypes unionSet:self.objectTypesWrite];
    }
    
    BOOL anyUndetermined = NO;
    NSUInteger countDenied = 0;
    NSUInteger countAuthorized = 0;
    
    for (HKObjectType *sampleType in allTypes) {
        HKAuthorizationStatus status = [self.store authorizationStatusForType:sampleType];
        switch (status) {
            case HKAuthorizationStatusNotDetermined:
                anyUndetermined = YES;
                break;
                
            case HKAuthorizationStatusSharingAuthorized:
                countAuthorized++;
                break;
                
            case HKAuthorizationStatusSharingDenied:
                countDenied++;
                break;
        }
    }
    
    if (anyUndetermined) {
        return [self internalPermissionState];
    }
    
    // for mixed results we simply vote:
    if (countDenied > countAuthorized) {
        return ISHPermissionStateDenied;
    }
    
    ALPHAScreenSection* permissionSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];*/
    
    return nil;
}

- (ALPHAScreenSection *)notificationSection
{
    return nil;
}

@end
