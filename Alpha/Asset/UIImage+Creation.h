//
//  UIImage+Creation.h
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

typedef void (^ALPHADrawingBlock)(CGSize size, NSDictionary* parameters);

extern NSString *const ALPHADrawingForegroundColorKey;

@interface UIImage (Creation)

/*!
 *  Returns 1x1 pt UIImage with color background
 *
 *  @param color of the image
 *
 *  @return UIImage instance
 */
+ (UIImage *)alpha_imageWithColor:(UIColor *)color;

/*!
 *  Returns circular image with radius
 *
 *  @param color  filled image
 *  @param radius of circle
 *
 *  @return UIImage instance
 */
+ (UIImage *)alpha_circularImageWithColor:(UIColor *)color radius:(CGFloat)radius;

/*!
 *  Drawing block should contain drawing code
 *
 *  @param size image size
 *  @param color image color
 *  @param drawingBlock to draw shape
 *
 *  @return UIImage instance
 */
+ (UIImage *)alpha_imageWithSize:(CGSize)size color:(UIColor *)color drawingBlock:(ALPHADrawingBlock)drawingBlock;

@end
