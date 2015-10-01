//
//  UIImage+Creation.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIImage+Creation.h"

NSString *const ALPHADrawingForegroundColorKey = @"kALPHADrawingForegroundColorKey";

@implementation UIImage (Creation)

+ (UIImage *)alpha_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)alpha_circularImageWithColor:(UIColor *)color radius:(CGFloat)radius
{
    CGFloat diameter = radius * 2.0;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(diameter, diameter), NO, 0.0);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(imageContext, [color CGColor]);
    CGContextFillEllipseInRect(imageContext, CGRectMake(0, 0, diameter, diameter));
    UIImage *circularImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circularImage;
}

+ (UIImage *)alpha_imageWithSize:(CGSize)size color:(UIColor *)color drawingBlock:(ALPHADrawingBlock)drawingBlock
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].nativeScale);

    if (!color)
    {
        color = [UIColor whiteColor];
    }
    
    [color setFill];
    [color setStroke];
    
    if (drawingBlock)
    {
        drawingBlock(size, @{ ALPHADrawingForegroundColorKey : color });
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
