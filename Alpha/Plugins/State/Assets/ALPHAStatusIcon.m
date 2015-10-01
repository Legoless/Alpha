//
//  ALPHAStatusIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAStatusIcon.h"

NSString *const ALPHAIconStatusIdentifier = @"com.unifiedsense.alpha.icon.status";

@implementation ALPHAStatusIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconStatusIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49134 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95266 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45160 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91266 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46941 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95266 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45160 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93475 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49134 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87266 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45160 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89057 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46941 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87266 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53105 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91266 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51328 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87266 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53105 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89057 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49134 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95266 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53105 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93475 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.51328 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95266 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45492 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53438 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54431 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53987 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54431 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09448 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53438 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54431 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10552 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53987 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45492 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44499 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44944 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.44499 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10552 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45492 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44499 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09448 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.44944 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03582 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72692 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30562 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22616 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.26174 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.22616 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03582 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22616 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30562 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.22616 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96418 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26174 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72692 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96418 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [fillColor setFill];
            [bezierPath fill];
        };
    }
    
    return self;
}

@end
