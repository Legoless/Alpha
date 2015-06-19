//
//  ALPHAFont.h
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import Foundation;

/*!
 *  Wraps Font Family and creates UI Font based on sizes
 */
@interface ALPHAFont : NSObject

@property (nonatomic, readonly) CGFloat defaultPointSize;
@property (nonatomic, readonly) NSString *fontFamily;

- (instancetype)initWithFontFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)defaultPointSize;

#pragma mark - Convenience methods

- (UIFont *)font;
- (UIFont *)italicFont;
- (UIFont *)boldFont;
- (UIFont *)boldItalicFont;

/*!
 *  Returns font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (UIFont *)fontOfSize:(CGFloat)size;

/*!
 *  Returns italic font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (UIFont *)italicFontOfSize:(CGFloat)size;

/*!
 *  Returns italic font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (UIFont *)boldFontOfSize:(CGFloat)size;

/*!
 *  Returns italic font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (UIFont *)boldItalicFontOfSize:(CGFloat)size;

/*!
 *  Returns font with font-size taken from original font
 *
 *  @param font with size
 *
 *  @return font instance
 */
- (UIFont *)fontWithFont:(UIFont *)font;

/*!
 *  Returns font with font-size taken from original font
 *
 *  @param font with size
 *
 *  @return font instance
 */
- (UIFont *)italicFontWithFont:(UIFont *)font;

/*!
 *  Returns font with font-size taken from original font
 *
 *  @param font with size
 *
 *  @return font instance
 */
- (UIFont *)boldFontWithFont:(UIFont *)font;

/*!
 *  Returns theme font with font-size taken from original font
 *
 *  @param font with size
 *
 *  @return font instance
 */
- (UIFont *)boldItalicFontWithFont:(UIFont *)font;

@end
