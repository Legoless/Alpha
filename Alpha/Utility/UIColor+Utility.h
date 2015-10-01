//
//  UIColor+Utility.h
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

@interface UIColor (Utility)

+ (UIColor *)alpha_consistentRandomColorForObject:(id)object;
+ (UIColor *)alpha_interpolatedColorFromStartColor:(UIColor *)startColor endColor:(UIColor *)endColor fraction:(CGFloat)fraction;

@end
