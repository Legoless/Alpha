//
//  UIColor+Utility.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor *)alpha_consistentRandomColorForObject:(id)object
{
    CGFloat hue = (((NSUInteger)object >> 4) % 256) / 255.0;
    return [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
}

+ (UIColor *)alpha_interpolatedColorFromStartColor:(UIColor *)startColor endColor:(UIColor *)endColor fraction:(CGFloat)fraction
{
    fraction = MIN(1, MAX(0, fraction));
    
    const CGFloat *c1 = CGColorGetComponents(startColor.CGColor);
    const CGFloat *c2 = CGColorGetComponents(endColor.CGColor);
    
    CGFloat r = c1[0] + (c2[0] - c1[0]) * fraction;
    CGFloat g = c1[1] + (c2[1] - c1[1]) * fraction;
    CGFloat b = c1[2] + (c2[2] - c1[2]) * fraction;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
