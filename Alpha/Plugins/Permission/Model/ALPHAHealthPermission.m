//
//  ALPHAHealthPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import HealthKit;

#import "NSString+Identifier.h"

#import "ALPHAHealthPermission.h"

@interface ALPHAHealthPermission ()

@end

@implementation ALPHAHealthPermission

#pragma mark - Getters and Setters

+ (HKHealthStore *)healthStore
{
    static dispatch_once_t onceToken;
    static HKHealthStore *healthStore;
    
    dispatch_once(&onceToken, ^{
        healthStore = [[HKHealthStore alloc] init];
    });
    
    return healthStore;
}

- (NSArray *)objectTypes
{
    return @[ @"Quantity", @"Category", @"Characteristic", @"Correlation", @"Workout" ];
}

- (HKObjectType *)objectType
{
    return [self objectTypeForIdentifier:self.identifier];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    HKObjectType *objectType = [self objectType];
    
    if (!objectType)
    {
        return ALPHAApplicationAuthorizationStatusUnsupported;
    }
    
    HKAuthorizationStatus authorizationStatus = [[[self class] healthStore] authorizationStatusForType:objectType];
    
    switch (authorizationStatus)
    {
        case HKAuthorizationStatusNotDetermined:
            return ALPHAApplicationAuthorizationStatusNotDetermined;
        case HKAuthorizationStatusSharingDenied:
            return ALPHAApplicationAuthorizationStatusDenied;
        case HKAuthorizationStatusSharingAuthorized:
            return ALPHAApplicationAuthorizationStatusAuthorized;
    }
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    [[[self class] healthStore] requestAuthorizationToShareTypes:nil readTypes:[NSSet setWithArray:@[ [self objectType] ]] completion:^(BOOL success, NSError * _Nullable error)
    {
        if (completion)
        {
            completion (self, (success) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, error);
        }
    }];
}

- (NSString *)name
{
    NSString* identifier = self.identifier.copy;
    
    for (NSString *type in [self objectTypes])
    {
        identifier = [identifier stringByReplacingOccurrencesOfString:[self stringForObjectTypeString:type] withString:@""];
    }
    
    identifier = [identifier alpha_cleanCodeIdentifier];
    
    return identifier.length > 0 ? identifier : @"Workout";
}

+ (NSArray *)allPermissions
{
    NSArray *permissionIdentifiers = [self permissionIdentifiers];
    
    NSMutableArray* permissions = [NSMutableArray array];
    
    for (NSString *identifier in permissionIdentifiers)
    {
        ALPHAPermission* permission = [[self alloc] initWithIdentifier:identifier];
        
        if (permission)
        {
            [permissions addObject:permission];
        }
    }
    
    return permissions.copy;
}

#pragma mark - Private Methods

- (NSString *)stringForObjectTypeString:(NSString *)type
{
    return [NSString stringWithFormat:@"HK%@TypeIdentifier", type];
}

- (HKObjectType *)objectTypeForIdentifier:(NSString *)identifier
{
    if (identifier == NULL)
    {
        return nil;
    }
    
    for (NSString *type in [self objectTypes])
    {
        NSString *objectTypeString = [self stringForObjectTypeString:type];
        
        if ([identifier containsString:objectTypeString])
        {
            NSString *selectorString = [NSString stringWithFormat:@"%@TypeForIdentifier:", type.lowercaseString];
            
            if ([type isEqualToString:@"Workout"])
            {
                selectorString = @"workoutType";
            }
            
            return [HKObjectType performSelector:NSSelectorFromString(selectorString) withObject:identifier];
        }
    }
    
    return nil;
}

+ (NSArray *)permissionIdentifiers
{
    NSMutableArray* identifiers = [@[
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
    ] mutableCopy];
    
    if (&HKQuantityTypeIdentifierBasalBodyTemperature != NULL)
    {
        [identifiers addObjectsFromArray:@[
            HKQuantityTypeIdentifierBasalBodyTemperature,       // Basal Body Temperature,      Discrete
            HKQuantityTypeIdentifierDietaryWater,               // Volume, Cumulative
            HKQuantityTypeIdentifierUVExposure                  // Scalar (Count), Discrete
        ]];
    }
    
    //
    // Category type
    //
    
    [identifiers addObjectsFromArray:@[
        HKCategoryTypeIdentifierSleepAnalysis
    ]];
    
    if (&HKCategoryTypeIdentifierAppleStandHour != NULL)
    {
        [identifiers addObjectsFromArray:@[
            HKCategoryTypeIdentifierAppleStandHour,            // HKCategoryValueAppleStandHour
            HKCategoryTypeIdentifierCervicalMucusQuality,      // HKCategoryValueCervicalMucusQuality
            HKCategoryTypeIdentifierOvulationTestResult,       // HKCategoryValueOvulationTestResult
            HKCategoryTypeIdentifierMenstrualFlow,             // HKCategoryValueMenstrualFlow
            HKCategoryTypeIdentifierIntermenstrualBleeding,    // (Spotting) HKCategoryValue
            HKCategoryTypeIdentifierSexualActivity,            // HKCategoryValue
        ]];
    }
    
    //
    // Characteristic type
    //
    
    [identifiers addObjectsFromArray:@[
        HKCharacteristicTypeIdentifierBiologicalSex,            // NSNumber (HKCharacteristicBiologicalSex)
        HKCharacteristicTypeIdentifierBloodType,                // NSNumber (HKCharacteristicBloodType)
        HKCharacteristicTypeIdentifierDateOfBirth,              // NSDate
    ]];
    
    //
    // Adds iOS9 only identifiers
    //
    if (&HKCharacteristicTypeIdentifierFitzpatrickSkinType != NULL)
    {
        [identifiers addObjectsFromArray:@[
            HKCharacteristicTypeIdentifierFitzpatrickSkinType   // HKFitzpatrickSkinType
        ]];
    }
    
    //
    // Correlation type
    //
    
    [identifiers addObjectsFromArray:@[
        HKCorrelationTypeIdentifierBloodPressure,
        HKCorrelationTypeIdentifierFood
    ]];
    
    //
    // Workout type
    //
    
    [identifiers addObject:HKWorkoutTypeIdentifier];
    
    return identifiers.copy;

}

@end
