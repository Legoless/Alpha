//
//  UIDevice+Hardware.h
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Hardware)

/**
 *  Returns current battery level of the device
 *
 *  @return battery level
 */
- (float)hay_batteryLevel;

//
// CPU Related
//

/*!
 * Number of CPU cores
 */
- (NSUInteger)hay_cpuCount;

/*!
 * Number of active CPU cores
 */
- (NSUInteger)hay_cpuActiveCount;

- (NSUInteger)hay_cpuPhysicalCount;

- (NSUInteger)hay_cpuPhysicalMaximumCount;

- (NSUInteger)hay_cpuLogicalCount;

- (NSUInteger)hay_cpuLogicalMaximumCount;

- (NSUInteger)hay_cpuFrequency;

- (NSUInteger)hay_cpuMaximumFrequency;

- (NSUInteger)hay_cpuMinimumFrequency;

- (NSString *)hay_cpuType;

- (NSString *)hay_cpuSubType;

- (NSString *)hay_cpuArchitectures;

//
// Memory Related
//

- (unsigned long long)hay_memoryMarketingSize;

/**
 *  Total RAM size
 *
 *  @return Total RAM size
 */
- (unsigned long long)hay_memoryPhysicalSize;

//
// Disk Space Related
//

- (unsigned long long)hay_diskMarketingSpace;

- (unsigned long long)hay_diskTotalSpace;

- (unsigned long long)hay_diskFreeSpace;

@end
