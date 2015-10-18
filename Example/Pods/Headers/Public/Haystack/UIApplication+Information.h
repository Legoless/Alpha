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
- (long long)hay_memorySize;

/**
 *  Returns current application thread count
 *
 *  @return thread count of current application
 */
- (NSUInteger)hay_threadCount;

/**
 *  Application's CPU usage
 *
 *  @return application's CPU usage
 */
- (float)hay_cpuUsage;

/**
 * Returns YES if application is currently running tests
 *
 *  @return YES when running tests
 */
- (BOOL)hay_isRunningTests;

@end
