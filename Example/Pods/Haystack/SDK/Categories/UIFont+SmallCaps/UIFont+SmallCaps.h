//
//  UIFont+SmallCaps.h
//

@import UIKit;

@interface UIFont (SmallCaps)

/*!
 * Returns new instance of same font in small cap format
 *
 * @return UIFont small cap font
 */
- (UIFont *)hay_smallCapFont;

/*!
 * Returns true if current font is of same family as system font
 */
- (BOOL)hay_isSystemFont;

/*!
 * Returns true if font has small caps available
 */
- (BOOL)hay_hasSmallCaps;

@end
