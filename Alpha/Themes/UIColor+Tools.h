//
//  UIColor+Tools.h
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

@interface UIColor (Tools)

- (CGFloat)alpha_brightness;
- (UIColor *)alpha_colorWithBrightnessModifier:(CGFloat)modifier;

@end
