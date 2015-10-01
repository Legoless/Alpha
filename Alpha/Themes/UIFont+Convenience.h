//
//  UIFont+Convenience.h
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

@interface UIFont (Convenience)

- (instancetype)regularFont;
- (instancetype)italicFont;
- (instancetype)boldFont;
- (instancetype)boldItalicFont;

/*!
 *  Converts font to regular font and applies size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (instancetype)regularFontWithSize:(CGFloat)size;

/*!
 *  Returns italic font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (instancetype)italicFontWithSize:(CGFloat)size;

/*!
 *  Returns italic font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (instancetype)boldFontWithSize:(CGFloat)size;

/*!
 *  Returns italic font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (instancetype)boldItalicFontWithSize:(CGFloat)size;

@end
