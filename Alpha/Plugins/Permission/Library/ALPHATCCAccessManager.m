//
//  ALPHATCCAccessManager.m
//  Alpha
//
//  Created by Dal Rupnik on 18/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHATCC.h"
#import "ALPHATCCAccessManager.h"

//
// These symbols are extracted from TCC.framework/TCC binary
//

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
    int access = TCCAccessRequest(ALPHATCCAccessBluetoothPeripheral, @"Testy", 0);
    NSLog(@"Access: %d", access);
}

+ (NSArray *)accessIdentifiers {
    return @[
        ALPHATCCAccessAddressBook,
        ALPHATCCAccessBluetoothPeripheral,
        ALPHATCCAccessCalendar,
        ALPHATCCAccessCamera,
        ALPHATCCAccessKeyboardNetwork,
        ALPHATCCAccessMicrophone,
        ALPHATCCAccessMotion,
        ALPHATCCAccessPhotos,
        ALPHATCCAccessReminders,
        ALPHATCCAccessFacebook,
        ALPHATCCAccessTwitter,
        ALPHATCCAccessSinaWeibo,
        ALPHATCCAccessTencentWeibo,
        ALPHATCCAccessWillow
    ];
}

@end
