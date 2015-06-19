//
//  ALPHAFont.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFont.h"

@interface ALPHAFont ()

@property (nonatomic, readwrite) CGFloat defaultPointSize;
@property (nonatomic, readwrite) NSString *fontFamily;

@end

@implementation ALPHAFont

- (instancetype)initWithFontFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)defaultPointSize
{
    self = [super init];
    
    if (self)
    {
        NSAssert (fontFamily.length > 0, @"Must specify a font family");
        
        NSAssert ([[UIFont familyNames] containsObject:fontFamily], @"Must specify a valid font family");
        NSAssert (defaultPointSize > 0, @"Default point size must not equal zero");
        
        self.fontFamily = fontFamily;
        self.defaultPointSize = defaultPointSize;
    }
    
    return self;
}

#pragma mark - Font Convenience methods

- (UIFont *)font
{
    return [self fontWithStyle:nil ofSize:self.defaultPointSize];
}

- (UIFont *)italicFont
{
    return [self fontWithStyle:@"Italic" ofSize:self.defaultPointSize];
}

- (UIFont *)boldFont
{
    return [self fontWithStyle:@"Bold" ofSize:self.defaultPointSize];
}

- (UIFont *)boldItalicFont
{
    return [self fontWithStyle:@"BoldItalic" ofSize:self.defaultPointSize];
}

- (UIFont *)italicFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:@"Italic" ofSize:size];
}

- (UIFont *)boldFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:@"Bold" ofSize:size];
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:@"BoldItalic" ofSize:size];
}

- (UIFont *)fontOfSize:(CGFloat)size
{
    return [self fontWithStyle:nil ofSize:size];
}

- (UIFont *)fontWithFont:(UIFont *)font
{
    return [self fontOfSize:font.pointSize];
}

- (UIFont *)italicFontWithFont:(UIFont *)font
{
    return [self italicFontOfSize:font.pointSize];
}

- (UIFont *)boldFontWithFont:(UIFont *)font
{
    return [self boldFontOfSize:font.pointSize];
}

- (UIFont *)boldItalicFontWithFont:(UIFont *)font
{
    return [self boldItalicFontOfSize:font.pointSize];
}

#pragma mark - Private Methods

- (UIFont *)fontWithStyle:(NSString *)fontStyle ofSize:(CGFloat)size
{
    NSString* fontFamily = self.fontFamily;
    
    if (fontStyle)
    {
        fontFamily = [NSString stringWithFormat:@"%@-%@", self.fontFamily, fontStyle];
    }
    
    return [UIFont fontWithName:fontFamily size:size - 2.0];
}

@end
