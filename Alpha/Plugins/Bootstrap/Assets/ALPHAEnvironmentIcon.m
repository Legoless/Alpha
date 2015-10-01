//
//  ALPHAEnvironmentIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEnvironmentIcon.h"

NSString *const ALPHAIconEnvironmentIdentifier = @"com.unifiedsense.alpha.icon.environment";

@implementation ALPHAEnvironmentIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconEnvironmentIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40234 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18261 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11426 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.03320 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28646 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.09082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19043 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27441 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03809 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38021 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85352 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14648 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.63802 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.75586 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04883 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40234 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59766 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40234 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75781 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24219 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13476 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.68619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17057 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.60026 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13476 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27832 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20996 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13476 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34277 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15983 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40234 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.21387 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26009 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17057 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32422 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40234 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59765 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40234 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59765 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24218 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75781 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86523 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.31380 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82942 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.39974 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86523 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79004 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86523 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65723 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84017 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85156 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59765 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.78613 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73991 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82942 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67578 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.99023 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59765 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81738 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88574 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.96680 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71354 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.90918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80957 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72559 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96191 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61979 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14648 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85351 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.24414 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95117 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [fillColor setFill];
            [bezierPath fill];

        };
    }
    
    return self;
}

@end
