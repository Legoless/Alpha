//
//  UIImage+Creation.h
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Creation)

/*!
 *  Returns 1x1 pt UIImage with color background
 *
 *  @param color of the image
 *
 *  @return UIImage instance
 */
+ (UIImage *)alpha_imageWithColor:(UIColor *)color;

@end
