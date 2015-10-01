//
//  ALPHASelectIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASelectIcon.h"

NSString *const ALPHAIconSelectIdentifier = @"com.unifiedsense.alpha.icon.select";

@implementation ALPHASelectIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconSelectIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02935 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68068 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22022 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65969 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.08202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62779 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.14110 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64851 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35066 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61759 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.28819 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66941 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35509 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65170 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31117 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46629 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34363 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56241 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33371 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53774 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22799 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20913 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29320 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40945 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25907 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30704 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22975 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00211 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.18640 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.07814 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17436 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01730 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35468 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17394 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.28944 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.01407 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.32365 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06475 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41897 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35027 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39002 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29828 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40860 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35314 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46019 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27909 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43728 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34537 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41225 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29221 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54852 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30205 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52013 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26292 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53174 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30641 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60745 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24031 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56528 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29738 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55958 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25330 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69945 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27689 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65545 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22741 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.67960 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28237 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74824 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24381 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.71909 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27149 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.71856 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25168 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.95345 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48485 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.77792 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23564 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.88957 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28206 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97067 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87355 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.03366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73982 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.94329 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78723 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61269 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41457 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88919 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58371 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93524 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49393 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93048 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.07173 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76983 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33456 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84735 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.28021 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76588 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02935 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68068 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00673 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77128 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.00306 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71322 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [fillColor setFill];
            [bezierPath fill];
        };
    }
    
    return self;
}

@end
