//
//  UIFont+Convenience.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIFont+Convenience.h"

typedef enum : NSUInteger {
    ALPHAFontTypeRegular,
    ALPHAFontTypeItalic,
    ALPHAFontTypeBold,
    ALPHAFontTypeBoldItalic
} ALPHAFontType;

@implementation UIFont (Convenience)

#pragma mark - Font Convenience methods

- (instancetype)regularFont
{
    return [self fontWithType:ALPHAFontTypeRegular ofSize:self.pointSize];
}

- (instancetype)italicFont
{
    return [self fontWithType:ALPHAFontTypeItalic ofSize:self.pointSize];
}

- (instancetype)boldFont
{
    return [self fontWithType:ALPHAFontTypeBold ofSize:self.pointSize];
}

- (instancetype)boldItalicFont
{
    return [self fontWithType:ALPHAFontTypeBoldItalic ofSize:self.pointSize];
}

- (instancetype)regularFontWithSize:(CGFloat)size
{
    return [self fontWithType:ALPHAFontTypeRegular ofSize:size];
}

- (instancetype)italicFontWithSize:(CGFloat)size
{
    return [self fontWithType:ALPHAFontTypeItalic ofSize:size];
}

- (instancetype)boldFontWithSize:(CGFloat)size
{
    return [self fontWithType:ALPHAFontTypeBold ofSize:size];
}

- (instancetype)boldItalicFontWithSize:(CGFloat)size
{
    return [self fontWithType:ALPHAFontTypeBoldItalic ofSize:size];
}

#pragma mark - Private Methods

- (UIFont *)fontWithType:(ALPHAFontType)type ofSize:(CGFloat)size
{
    return [self fontWithFontTypeString:[self fontTypeStringForType:type] ofSize:size];
}

/*!
 *  Returns same font family with different modifier (bold, italic, etc...)
 *
 *  @param fontTypeString type string to be appended to font (such as Bold, Italic, Wide, Book, ...)
 *  @param size           size of font
 *
 *  @return nil if font type is not available, font instance otherwise
 */
- (UIFont *)fontWithFontTypeString:(NSString *)fontTypeString ofSize:(CGFloat)size
{
    NSString* fontFamily = [self fontFamilyFromFontName:self.fontName];
    NSString* currentFontTypeString = [self fontTypeStringForFontName:self.fontName];
    
    //
    // If font types do not match, we create new font
    //
    if (![currentFontTypeString isEqualToString:fontTypeString])
    {
        //
        // Regular is an exception, since some fonts have '-Regular' prefix.
        //
        
        UIFont *font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-%@", fontFamily, fontTypeString] size:size];
        
        if (!font)
        {
            font = [UIFont fontWithName:[NSString stringWithFormat:@"%@", fontFamily] size:size];
        }
        
        return font;
    }
    else
    {
        return [self fontWithSize:size];
    }
}

- (NSString *)fontTypeStringForFontName:(NSString *)fontName
{
    NSRange lastDashRange = [fontName rangeOfString:@"-" options:NSBackwardsSearch];
    
    if (lastDashRange.location != NSNotFound)
    {
        return [fontName substringFromIndex:lastDashRange.location];
    }
    
    return @"Regular";
}

- (ALPHAFontType)fontTypeForFontName:(NSString *)fontName
{
    if ([fontName containsString:@"BoldItalic"])
    {
        return ALPHAFontTypeBoldItalic;
    }
    else if ([fontName containsString:@"Bold"])
    {
        return ALPHAFontTypeBold;
    }
    else if ([fontName containsString:@"Italic"])
    {
        return ALPHAFontTypeItalic;
    }
    
    return ALPHAFontTypeRegular;
}

- (NSString *)fontTypeStringForType:(ALPHAFontType)fontType
{
    switch (fontType)
    {
        case ALPHAFontTypeBoldItalic:
            return @"BoldItalic";
        case ALPHAFontTypeBold:
            return @"Bold";
        case ALPHAFontTypeItalic:
            return @"Italic";
        default:
            return @"Regular";
    }
}

/*!
 *  Returns raw font family from font name: HelveticaNeue-Regular -> HelveticaNeue
 *
 *  @param fontName font name
 *
 *  @return font family
 */
- (NSString *)fontFamilyFromFontName:(NSString *)fontName
{
    fontName = [fontName stringByReplacingOccurrencesOfString:@"BoldItalic" withString:@""];
    fontName = [fontName stringByReplacingOccurrencesOfString:@"Bold" withString:@""];
    fontName = [fontName stringByReplacingOccurrencesOfString:@"Italic" withString:@""];
    fontName = [fontName stringByReplacingOccurrencesOfString:@"Regular" withString:@""];
    
    if ([fontName hasSuffix:@"-"])
    {
        fontName = [fontName substringToIndex:fontName.length - 2];
    }
    
    return fontName;
}

@end
