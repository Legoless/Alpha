//
//  UIColor+Tools.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Tools.h"

@implementation UIColor (Tools)

- (CGFloat)alpha_brightness
{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    BOOL success = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    if (success)
    {
        return brightness;
    }
    
    return 0.0;
}


- (UIColor *)alpha_colorWithBrightnessModifier:(CGFloat)modifier
{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    BOOL success = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    if (success)
    {
        brightness += modifier;
        
        if (brightness > 1.0)
        {
            brightness = 1.0;
        }
        
        if (brightness < 0.0)
        {
            brightness = 0.0;
        }
        
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
    
    return self;
}


@end
