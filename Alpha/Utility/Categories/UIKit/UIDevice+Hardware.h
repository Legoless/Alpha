//
//  UIDevice+Hardware.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
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
- (float)alpha_batteryLevel;

//
// CPU Related
//

/*!
 * Number of CPU cores
 */
- (NSUInteger)alpha_cpuCount;

/*!
 * Number of active CPU cores
 */
- (NSUInteger)alpha_cpuActiveCount;

- (NSUInteger)alpha_cpuPhysicalCount;

- (NSUInteger)alpha_cpuPhysicalMaximumCount;

- (NSUInteger)alpha_cpuLogicalCount;

- (NSUInteger)alpha_cpuLogicalMaximumCount;

- (NSUInteger)alpha_cpuFrequency;

- (NSUInteger)alpha_cpuMaximumFrequency;

- (NSUInteger)alpha_cpuMinimumFrequency;

- (NSString *)alpha_cpuType;

- (NSString *)alpha_cpuSubType;

- (NSString *)alpha_cpuArchitectures;

//
// Memory Related
//

- (unsigned long long)alpha_memoryMarketingSize;

/**
 *  Total RAM size
 *
 *  @return Total RAM size
 */
- (unsigned long long)alpha_memoryPhysicalSize;

//
// Disk Space Related
//

- (unsigned long long)alpha_diskMarketingSpace;

- (unsigned long long)alpha_diskTotalSpace;

- (unsigned long long)alpha_diskFreeSpace;

@end
