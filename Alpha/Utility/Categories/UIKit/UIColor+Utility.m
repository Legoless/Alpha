//
//  UIColor+Utility.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
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

+ (UIColor *)alpha_colorWithHex:(NSString *)hex
{
    //
    // Test for hash on start, remove it if necessary
    //
    
    if ([hex characterAtIndex:0] == '#') {
        hex = [hex substringFromIndex:1];
    }
    
    unsigned alphaInt = 0;
    
    if ([hex length] == 8) {
        NSString *alphaHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
        
        NSScanner *rScanner = [NSScanner scannerWithString:alphaHex];
        [rScanner scanHexInt:&alphaInt];
        
        hex = [hex substringFromIndex:2];
    }
    else if ([hex length] == 6) {
        alphaInt = 255;
    }
    else {
        return nil;
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(0, 2)]];
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(2, 2)]];
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(4, 2)]];
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [UIColor colorWithRed:redInt / 255.0 green:greenInt / 255.0 blue:blueInt / 255.0 alpha:alphaInt / 255.0];
}

@end
