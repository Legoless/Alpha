//
//  UIDevice+Software.h
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Software)

//
// Process related information
//

- (NSArray *)hs_processList;

- (NSUInteger)hs_processCount;

- (float)hs_cpuUsage;

@end
