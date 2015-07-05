//
//  UIApplication+Version.h
//

@import UIKit;

@interface UIApplication (Version)

/*!
 * Returns application name as defined in bundle.
 *
 * @return NSString application name
 */
- (NSString *)hay_name;

/*!
 * Returns version number in x.y.z format
 *
 * @return NSString version number
 */
- (NSString *)hay_version;

/*!
* Returns build number as defined in bundle.
*
 * @return NSString build number
*/
- (NSString *)hay_build;

/**
 *  Returns main bundle identifier
 *
 *  @return main bundle identifier
 */
- (NSString *)hay_bundleIdentifier;

@end
