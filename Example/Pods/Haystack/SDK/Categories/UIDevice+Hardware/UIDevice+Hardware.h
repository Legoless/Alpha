//
//  UIDevice+Hardware.h
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Hardware)

//
// CPU Related
//

- (NSUInteger)hs_cpuCount;

- (NSUInteger)hs_cpuActiveCount;

- (NSUInteger)hs_cpuPhysicalCount;

- (NSUInteger)hs_cpuPhysicalMaximumCount;

- (NSUInteger)hs_cpuLogicalCount;

- (NSUInteger)hs_cpuLogicalMaximumCount;

- (NSUInteger)hs_cpuFrequency;

- (NSUInteger)hs_cpuMaximumFrequency;

- (NSUInteger)hs_cpuMinimumFrequency;

- (NSString *)hs_cpuType;

- (NSString *)hs_cpuSubType;

- (NSString *)hs_cpuArchitectures;

//
// Memory Related
//

- (unsigned long long)hs_memoryMarketingSize;

/**
 *  Total RAM size
 *
 *  @return Total RAM size
 */
- (unsigned long long)hs_memoryPhysicalSize;

//
// Disk Space Related
//

- (unsigned long long)hs_diskMarketingSpace;

- (unsigned long long)hs_diskTotalSpace;

- (unsigned long long)hs_diskFreeSpace;

//
// Network Related
//


/**
 *  Returns MAC address of network adapter
 *
 *  @return MAC address in formatted shape
 */
- (NSString *)hs_macAddress;


@end
