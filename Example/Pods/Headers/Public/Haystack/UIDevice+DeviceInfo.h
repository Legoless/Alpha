//
//  UIDevice+DeviceInfo.h
//

@import UIKit;

/*!
 * Device family enum
 */
typedef NS_ENUM(NSUInteger, HAYDeviceFamily)
{
    HAYDeviceFamilyiPhone,
    HAYDeviceFamilyiPod,
    HAYDeviceFamilyiPad,
    HAYDeviceFamilyAppleTV,
    HAYDeviceFamilyUnknown,
};

/*!
 * Category displays detailed information about current device
 */
@interface UIDevice (DeviceInfo)

/*!
 * Returns YES if device is iPhone.
 */
- (BOOL)hay_isiPhone;

/*!
 * Returns YES if device is iPod.
 */
- (BOOL)hay_isiPod;

/*!
 * Returns YES if device is iPad.
 */
- (BOOL)hay_isiPad;

/*!
 * Returns if the device is iPhone 5 or iPod touch that has widescreen display of 16:9 ratio.
 */
- (BOOL)hay_isWidescreen;

/*!
 * Returns formatted consumer hay_name of Apple device
 */
- (NSString *)hay_modelIdentifier;

/*!
 * Returns model hay_name.
 */
- (NSString *)hay_modelName;

/*!
 * Returns device family of the device
 */
- (HAYDeviceFamily)hay_deviceFamily;

/**
 *  Returns specific system information by name
 *
 *  @param hay_name type specifier
 *
 *  @return system information in human readable format
 */
- (NSString *)hay_systemInfoByName:(NSString *)name;

@end
