//
//  ALPHATCCAccessManager.h
//  Alpha
//
//  Created by Dal Rupnik on 18/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

extern NSString *const ALPHATCCAccessAddressBook;
extern NSString *const ALPHATCCAccessBluetoothPeripheral;
extern NSString *const ALPHATCCAccessCalendar;
extern NSString *const ALPHATCCAccessCamera;
extern NSString *const ALPHATCCAccessKeyboardNetwork;
extern NSString *const ALPHATCCAccessMicrophone;
extern NSString *const ALPHATCCAccessMotion;
extern NSString *const ALPHATCCAccessPhotos;
extern NSString *const ALPHATCCAccessReminders;

extern NSString *const ALPHATCCAccessFacebook;
extern NSString *const ALPHATCCAccessTwitter;
extern NSString *const ALPHATCCAccessSinaWeibo;
extern NSString *const ALPHATCCAccessTencentWeibo;
extern NSString *const ALPHATCCAccessWillow;

@interface ALPHATCCAccessManager : NSObject

+ (NSArray *)accessIdentifiers;

@end
