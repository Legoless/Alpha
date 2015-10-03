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
@import CoreBluetooth;
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

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation ALPHAPermissionSource

#pragma mark - Getters and Setters

#pragma mark - Initialization

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

#pragma mark - ALPHADataSource

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    //
    // TODO: Add Notifications and healthkit permissions
    //
    
    CBCentralManager* centralManager = [[CBCentralManager alloc] initWithDelegate:nil queue:nil];
    
    NSDictionary* sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.permission.list",
                     @"items" : @[
                             @{ @"Bluetooth" : [self stringForBluetoothPermissionStatus:centralManager.state] },
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
    
    //[array addObject:[self notificationSection]];
    
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

- (ALPHAScreenSection *)healthSection
{
    //
    // No HealthKit available
    //
    if (![HKHealthStore isHealthDataAvailable])
    {
        return nil;
    }
    
    NSMutableArray *items = [NSMutableArray array];

    
    HKHealthStore *store = [[HKHealthStore alloc] init];

    for (HKObjectType *sampleType in [self healthObjectTypes])
    {
        ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
        item.title = sampleType.identifier;
        item.detail = [self stringForHealthPermissionStatus:[store authorizationStatusForType:sampleType]];
        item.style = UITableViewCellStyleValue1;
        
        [items addObject:item];
    }
    
    ALPHAScreenSection *section = [[ALPHAScreenSection alloc] initWithIdentifier:@"com.unifiedsense.alpha.data.permission.health" title:@"Health"];
    section.items = items.copy;
    
    return section;
}

- (NSOrderedSet *)healthObjectTypes
{
    NSMutableOrderedSet *allTypes = [NSMutableOrderedSet orderedSet];
    
    //
    // Quantity types
    //
    
    NSArray* identifiers = @[
        // Body Measurements
        HKQuantityTypeIdentifierBodyMassIndex,                  // Scalar(Count),               Discrete
        HKQuantityTypeIdentifierBodyFatPercentage,              // Scalar(Percent, 0.0 - 1.0),  Discrete
        HKQuantityTypeIdentifierHeight,                         // Length,                      Discrete
        HKQuantityTypeIdentifierBodyMass,                       // Mass,                        Discrete
        HKQuantityTypeIdentifierLeanBodyMass,                   // Mass,                        Discrete

        // Fitness
        HKQuantityTypeIdentifierStepCount,                      // Scalar(Count),               Cumulative
        HKQuantityTypeIdentifierDistanceWalkingRunning,         // Length,                      Cumulative
        HKQuantityTypeIdentifierDistanceCycling,                // Length,                      Cumulative
        HKQuantityTypeIdentifierBasalEnergyBurned,              // Energy,                      Cumulative
        HKQuantityTypeIdentifierActiveEnergyBurned,             // Energy,                      Cumulative
        HKQuantityTypeIdentifierFlightsClimbed,                 // Scalar(Count),               Cumulative
        HKQuantityTypeIdentifierNikeFuel,                       // Scalar(Count),               Cumulative

        // Vitals
        HKQuantityTypeIdentifierHeartRate,                      // Scalar(Count)/Time,          Discrete
        HKQuantityTypeIdentifierBodyTemperature,                // Temperature,                 Discrete

        HKQuantityTypeIdentifierBloodPressureSystolic,          // Pressure,                    Discrete
        HKQuantityTypeIdentifierBloodPressureDiastolic,         // Pressure,                    Discrete
        HKQuantityTypeIdentifierRespiratoryRate,                // Scalar(Count)/Time,          Discrete

        // Results
        HKQuantityTypeIdentifierOxygenSaturation,               // Scalar (Percent, 0.0 - 1.0,  Discrete
        HKQuantityTypeIdentifierPeripheralPerfusionIndex,       // Scalar(Percent, 0.0 - 1.0),  Discrete
        HKQuantityTypeIdentifierBloodGlucose,                   // Mass/Volume,                 Discrete
        HKQuantityTypeIdentifierNumberOfTimesFallen,            // Scalar(Count),               Cumulative
        HKQuantityTypeIdentifierElectrodermalActivity,          // Conductance,                 Discrete
        HKQuantityTypeIdentifierInhalerUsage,                   // Scalar(Count),               Cumulative
        HKQuantityTypeIdentifierBloodAlcoholContent,            // Scalar(Percent, 0.0 - 1.0),  Discrete
        HKQuantityTypeIdentifierForcedVitalCapacity,            // Volume,                      Discrete
        HKQuantityTypeIdentifierForcedExpiratoryVolume1,        // Volume,                      Discrete
        HKQuantityTypeIdentifierPeakExpiratoryFlowRate,         // Volume/Time,                 Discrete

        // Nutrition
        HKQuantityTypeIdentifierDietaryFatTotal,                // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryFatPolyunsaturated,      // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryFatMonounsaturated,      // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryFatSaturated,            // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryCholesterol,             // Mass,   Cumulative
        HKQuantityTypeIdentifierDietarySodium,                  // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryCarbohydrates,           // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryFiber,                   // Mass,   Cumulative
        HKQuantityTypeIdentifierDietarySugar,                   // Mass,   Cumulative
        HKQuantityTypeIdentifierDietaryEnergyConsumed,          // Energy, Cumulative
        HKQuantityTypeIdentifierDietaryProtein,                 // Mass,   Cumulative

        HKQuantityTypeIdentifierDietaryVitaminA,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryVitaminB6,               // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryVitaminB12,              // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryVitaminC,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryVitaminD,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryVitaminE,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryVitaminK,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryCalcium,                 // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryIron,                    // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryThiamin,                 // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryRiboflavin,              // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryNiacin,                  // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryFolate,                  // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryBiotin,                  // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryPantothenicAcid,         // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryPhosphorus,              // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryIodine,                  // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryMagnesium,               // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryZinc,                    // Mass, Cumulative
        HKQuantityTypeIdentifierDietarySelenium,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryCopper,                  // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryManganese,               // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryChromium,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryMolybdenum,              // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryChloride,                // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryPotassium,               // Mass, Cumulative
        HKQuantityTypeIdentifierDietaryCaffeine                 // Mass, Cumulative
    ];
    
    //
    // Adds iOS9 only identifiers
    //
    if (&HKQuantityTypeIdentifierBasalBodyTemperature != NULL)
    {
        identifiers = [identifiers arrayByAddingObjectsFromArray:@[
            HKQuantityTypeIdentifierBasalBodyTemperature,       // Basal Body Temperature,      Discrete
            HKQuantityTypeIdentifierDietaryWater,               // Volume, Cumulative
            HKQuantityTypeIdentifierUVExposure                  // Scalar (Count), Discrete
        ]];
    }
    
    for (NSString* identifier in identifiers)
    {
        [allTypes addObject:[HKObjectType quantityTypeForIdentifier:identifier]];
    }
    
    //
    // Category type
    //
    
    identifiers = @[
        HKCategoryTypeIdentifierSleepAnalysis
    ];
    
    //
    // Adds iOS9 only identifiers
    //
    if (&HKCategoryTypeIdentifierAppleStandHour != NULL)
    {
        identifiers = [identifiers arrayByAddingObjectsFromArray:@[
            HKCategoryTypeIdentifierAppleStandHour,            // HKCategoryValueAppleStandHour
            HKCategoryTypeIdentifierCervicalMucusQuality,      // HKCategoryValueCervicalMucusQuality
            HKCategoryTypeIdentifierOvulationTestResult,       // HKCategoryValueOvulationTestResult
            HKCategoryTypeIdentifierMenstrualFlow,             // HKCategoryValueMenstrualFlow
            HKCategoryTypeIdentifierIntermenstrualBleeding,    // (Spotting) HKCategoryValue
            HKCategoryTypeIdentifierSexualActivity,            // HKCategoryValue
        ]];
    }
    
    for (NSString* identifier in identifiers)
    {
        [allTypes addObject:[HKObjectType categoryTypeForIdentifier:identifier]];
    }
    
    //
    // Characteristic type
    //
    
    identifiers = @[
        HKCharacteristicTypeIdentifierBiologicalSex,            // NSNumber (HKCharacteristicBiologicalSex)
        HKCharacteristicTypeIdentifierBloodType,                // NSNumber (HKCharacteristicBloodType)
        HKCharacteristicTypeIdentifierDateOfBirth,              // NSDate
    ];
    
    //
    // Adds iOS9 only identifiers
    //
    if (&HKCharacteristicTypeIdentifierFitzpatrickSkinType != NULL)
    {
        identifiers = [identifiers arrayByAddingObjectsFromArray:@[
            HKCharacteristicTypeIdentifierFitzpatrickSkinType   // HKFitzpatrickSkinType
        ]];
    }
    
    for (NSString* identifier in identifiers)
    {
        [allTypes addObject:[HKObjectType characteristicTypeForIdentifier:identifier]];
    }
    
    //
    // Correlation type
    //
    
    identifiers = @[
        HKCorrelationTypeIdentifierBloodPressure,
        HKCorrelationTypeIdentifierFood
    ];
    
    for (NSString* identifier in identifiers)
    {
        [allTypes addObject:[HKObjectType correlationTypeForIdentifier:identifier]];
    }
    
    //
    // Workout type
    //
    
    [allTypes addObject:[HKObjectType workoutType]];
    
    return allTypes.copy;
}

- (ALPHAScreenSection *)notificationSection
{
    return nil;
}

#pragma mark - Permission Conversion

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

- (NSString *)stringForBluetoothPermissionStatus:(CBCentralManagerState)state
{
    switch (state)
    {
        case CBCentralManagerStateUnsupported:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusUnsupported);
        case CBCentralManagerStateUnauthorized:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusDenied);
        default:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusNotDetermined);
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

- (NSString *)stringForHealthPermissionStatus:(HKAuthorizationStatus)status
{
    switch (status)
    {
        case HKAuthorizationStatusNotDetermined:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusNotDetermined);
        case HKAuthorizationStatusSharingDenied:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusDenied);
        case HKAuthorizationStatusSharingAuthorized:
            return NSStringFromAuthorizationStatus(ALPHAApplicationAuthorizationStatusAuthorized);
    }
}

@end
