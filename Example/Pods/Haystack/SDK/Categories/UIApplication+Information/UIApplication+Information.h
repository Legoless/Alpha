//
//  UIApplication+Information.h
//

@import UIKit;

@interface UIApplication (Information)

/**
 *  Current memory footprint of the application
 *
 *  @return memory footprint
 */
- (long long)memorySize;

/**
 *  Returns current application thread count
 *
 *  @return thread count of current application
 */
- (NSUInteger)threadCount;

/**
 *  Application's CPU usage
 *
 *  @return application's CPU usage
 */
- (float)cpuUsage;

/**
 * Returns YES if application is currently running tests
 *
 *  @return YES when running tests
 */
- (BOOL)isRunningTests;

@end
