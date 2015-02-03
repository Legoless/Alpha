//
//  UIDevice+Software.h
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Software)

/**
 *  Returns YES if device is jailbroken after series of tests
 *
 *  @return YES if device is jailbroken
 */
- (BOOL)isJailbroken;

/**
 *  Returns device boot date
 *
 *  @return device boot date
 */
- (NSDate *)hs_systemBootDate;

//
// Process related information
//

- (NSArray *)hs_processList;

- (NSUInteger)hs_processCount;

- (float)hs_cpuUsage;

@end
