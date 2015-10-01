//
//  ALPHAKeychainIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 01/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAKeychainIcon.h"

NSString *const ALPHAIconKeychainIdentifier = @"com.unifiedsense.alpha.icon.keychain";

@implementation ALPHAKeychainIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconKeychainIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28550 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18800 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45189 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28550 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24182 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09050 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13418 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45189 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09050 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18800 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56069 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09050 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13418 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28550 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24182 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56069 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28550 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01250 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26600 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36480 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01250 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12595 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37146 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31513 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46182 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92900 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98750 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85100 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56538 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77300 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69500 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56538 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61700 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57800 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60481 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26600 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69741 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46182 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37146 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12595 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01250 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [fillColor setFill];
            [bezierPath fill];
        };
    }
    
    return self;
}

@end
