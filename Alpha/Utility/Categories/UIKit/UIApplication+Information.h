//
//  UIApplication+Information.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import UIKit;

@interface UIApplication (Information)

/**
 *  Current memory footprint of the application
 *
 *  @return memory footprint
 */
- (long long)alpha_memorySize;

/**
 *  Returns current application thread count
 *
 *  @return thread count of current application
 */
- (NSUInteger)alpha_threadCount;

/**
 *  Application's CPU usage
 *
 *  @return application's CPU usage
 */
- (float)alpha_cpuUsage;

/**
 * Returns YES if application is currently running tests
 *
 *  @return YES when running tests
 */
- (BOOL)alpha_isRunningTests;

@end
