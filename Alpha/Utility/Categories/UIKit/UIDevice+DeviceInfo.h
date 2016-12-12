//
//  UIDevice+DeviceInfo.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import UIKit;

/*!
 * Device family enum
 */
typedef NS_ENUM(NSUInteger, ALPHADeviceFamily)
{
    ALPHADeviceFamilyiPhone,
    ALPHADeviceFamilyiPod,
    ALPHADeviceFamilyiPad,
    ALPHADeviceFamilyAppleTV,
    ALPHADeviceFamilyWatch,
    ALPHADeviceFamilyUnknown,
};

/*!
 * Category displays detailed information about current device
 */
@interface UIDevice (DeviceInfo)

/*!
 * Returns YES if device is iPhone.
 */
- (BOOL)alpha_isiPhone;

/*!
 * Returns YES if device is iPod.
 */
- (BOOL)alpha_isiPod;

/*!
 * Returns YES if device is iPad.
 */
- (BOOL)alpha_isiPad;

/*!
 * Returns YES if device is Apple Watch.
 */
- (BOOL)alpha_isWatch;

/*!
 * Returns if the device is iPhone 5 or iPod touch that has widescreen display of 16:9 ratio.
 */
- (BOOL)alpha_isWidescreen;

/*!
 * Returns formatted consumer hay_name of Apple device
 */
- (NSString *)alpha_modelIdentifier;

/*!
 * Returns model hay_name.
 */
- (NSString *)alpha_modelName;

/*!
 * Returns device family of the device
 */
- (ALPHADeviceFamily)alpha_deviceFamily;

/**
 *  Returns specific system information by name
 *
 *  @param name type specifier
 *
 *  @return system information in human readable format
 */
- (NSString *)alpha_systemInfoByName:(NSString *)name;

@end
