//
//  ALPHATCCAccessManager.m
//  Alpha
//
//  Created by Dal Rupnik on 18/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"

#import "ALPHATCCAccessManager.h"

NSString *const ALPHATCCAccessAddressBook               = @"kTCCServiceAddressBook";
NSString *const ALPHATCCAccessBluetoothPeripheral       = @"kTCCServiceBluetoothPeripheral";
NSString *const ALPHATCCAccessCalendar                  = @"kTCCServiceCalendar";
NSString *const ALPHATCCAccessCamera                    = @"kTCCServiceCamera";
NSString *const ALPHATCCAccessKeyboardNetwork           = @"kTCCServiceKeyboardNetwork"; // HomeKit
NSString *const ALPHATCCAccessMicrophone                = @"kTCCServiceMicrophone";
NSString *const ALPHATCCAccessMotion                    = @"kTCCServiceMotion";
NSString *const ALPHATCCAccessPhotos                    = @"kTCCServicePhotos";
NSString *const ALPHATCCAccessReminders                 = @"kTCCServiceReminders";

NSString *const ALPHATCCAccessFacebook                  = @"kTCCServiceFacebook";
NSString *const ALPHATCCAccessTwitter                   = @"kTCCServiceTwitter";
NSString *const ALPHATCCAccessSinaWeibo                 = @"kTCCServiceSinaWeibo";
NSString *const ALPHATCCAccessTencentWeibo              = @"kTCCServiceTencentWeibo";
NSString *const ALPHATCCAccessWillow                    = @"kTCCServiceWillow";

@implementation ALPHATCCAccessManager

+ (void)test
{
    [ALPHARuntimeUtility loadPrivateFramework:@"Preferences"];
    [ALPHARuntimeUtility loadPrivateFramework:@"TCC"];
    
    [NSClassFromString(@"PSSystemPolicyManager") performSelector:NSSelectorFromString(@"_populateBBSectionIDs")];
    
    id dataUsageWorkSpace = [NSClassFromString(@"PSSystemPolicyManager") performSelector:NSSelectorFromString(@"thirdPartyApplicationProxies")];
    
    //NSLog(@"DATA: %@", dataUsageWorkSpace);
    
    //NSLog(@"DATA: %@", [[dataUsageWorkSpace lastObject] performSelector:NSSelectorFromString(@"applicationIdentifier")]);
    
    
    
    id systempolicy = [[NSClassFromString(@"PSSystemPolicyForApp") alloc] performSelector:NSSelectorFromString(@"initWithBundleIdentifier:") withObject:@"com.google.Maps"];
    NSLog(@"DATA: %@", systempolicy);
}

+ (NSArray *)accessIdentifiers
{
    return nil;
}

@end
