//
//  ALPHAKeychainItem.h
//  Alpha
//
//  Created by Dal Rupnik on 01/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "ALPHASerialization.h"

typedef enum : NSUInteger
{
    ALPHAKeychainAccessibilityTypeWhenUnlocked,
    ALPHAKeychainAccessibilityTypeAfterFirstUnlock,
    ALPHAKeychainAccessibilityTypeAlways,
    ALPHAKeychainAccessibilityTypeWhenPasscodeSetThisDeviceOnly,
    ALPHAKeychainAccessibilityTypeWhenUnlockedThisDeviceOnly,
    ALPHAKeychainAccessibilityTypeAfterFirstUnlockThisDeviceOnly,
    ALPHAKeychainAccessibilityTypeAlwaysThisDeviceOnly
} ALPHAKeychainAccessibilityType;


@interface ALPHAKeychainItem : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *service;

@property (nonatomic, copy) NSData *value;
@property (nonatomic, copy) NSString *valueString;

@property (nonatomic, copy) NSNumber *accessibilityType;

@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) NSDate *modifiedDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
