//
//  UIApplication+Version.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import UIKit;

@interface UIApplication (Version)

/*!
 * Returns application name as defined in bundle.
 *
 * @return NSString application name
 */
- (NSString *)alpha_name;

/*!
 * Returns version number in x.y.z format
 *
 * @return NSString version number
 */
- (NSString *)alpha_version;

/*!
 * Returns build number as defined in bundle.
 *
 * @return NSString build number
 */
- (NSString *)alpha_build;

/**
 *  Returns main bundle identifier
 *
 *  @return main bundle identifier
 */
- (NSString *)alpha_bundleIdentifier;

@end
