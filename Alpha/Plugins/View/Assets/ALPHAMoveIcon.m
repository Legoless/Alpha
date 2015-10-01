//
//  ALPHAMoveIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMoveIcon.h"

NSString *const ALPHAIconMoveIdentifier = @"com.unifiedsense.alpha.icon.move";

@implementation ALPHAMoveIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconMoveIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect moveGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
            
            //// Move Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.42857 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.35714 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.20368 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33203 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.34747 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.21075 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33910 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.17857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32143 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.19662 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32496 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.18824 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32143 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.15346 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33203 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.16890 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32143 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.16052 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32496 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.01060 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.47489 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.00000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.50000 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.00353 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.48196 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.00000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.49033 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.01060 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.52511 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.00000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.50967 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.00353 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.51804 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.15346 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.66797 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.17857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67857 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.16052 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67504 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.16890 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67857 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.20368 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.66797 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.18824 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67857 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.19662 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67504 * CGRectGetHeight(moveGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.64286 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.21075 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.66090 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.65253 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.57143 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.33337 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.57143 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.33337 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.42857 * CGRectGetHeight(moveGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.21428 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.42857 * CGRectGetHeight(moveGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.57143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.64286 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.66797 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.20368 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.65253 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.66090 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21075 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.67857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.17857 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.67503 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.19661 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.67857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.18824 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.66797 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.15346 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.67857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.16890 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.67503 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.16052 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.52511 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.01060 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.50000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.00000 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.51804 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.00353 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.50967 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.00000 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.47489 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.01060 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.49033 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.00000 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.48195 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.00353 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.33203 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.15346 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.32142 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.17857 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.32496 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.16052 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.32142 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.16890 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.33203 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.20368 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.32142 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.18824 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.32496 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.19661 * CGRectGetHeight(moveGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.35714 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.33910 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21075 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.34747 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.42857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.42857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33956 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.57143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33956 * CGRectGetHeight(moveGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.57143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.21428 * CGRectGetHeight(moveGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.42857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.35714 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.33203 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.79632 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.34747 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.33910 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78925 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.32143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.82143 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.32496 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.80339 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.32143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.81176 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.33203 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.84654 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.32143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.83110 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.32496 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.83948 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.47489 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.98940 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.50000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 1.00000 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.48196 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.99647 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.49032 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 1.00000 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.52511 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.98940 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.50967 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 1.00000 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.51804 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.99647 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.66797 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.84654 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.67857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.82143 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.67504 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.83948 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.67857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.83110 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.66797 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.79632 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.67857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.81176 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.67504 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.80339 * CGRectGetHeight(moveGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.64285 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.66090 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78925 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.65253 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.57143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.57143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67283 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.42857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67283 * CGRectGetHeight(moveGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.42857 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.78572 * CGRectGetHeight(moveGroup))];
                [bezier3Path closePath];
                [fillColor setFill];
                [bezier3Path fill];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
                [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.98940 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.47489 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.84654 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33203 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.82143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32143 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.83947 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32496 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.83110 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32143 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.79632 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33203 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.81176 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32143 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.80338 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.32496 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.78572 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.35714 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.78925 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.33910 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.78572 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.34747 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.78572 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.42857 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.66663 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.42857 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.66663 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.57143 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.78572 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.57143 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.78572 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.64286 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.79632 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.66797 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.78572 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.65253 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.78925 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.66090 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.82143 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67857 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.80338 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67504 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.81176 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67857 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.84654 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.66797 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.83110 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67857 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.83947 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.67504 * CGRectGetHeight(moveGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.98940 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.52511 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 1.00000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.50000 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 0.99646 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.51805 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 1.00000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.50967 * CGRectGetHeight(moveGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(moveGroup) + 0.98940 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.47489 * CGRectGetHeight(moveGroup)) controlPoint1: CGPointMake(CGRectGetMinX(moveGroup) + 1.00000 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.49033 * CGRectGetHeight(moveGroup)) controlPoint2: CGPointMake(CGRectGetMinX(moveGroup) + 0.99646 * CGRectGetWidth(moveGroup), CGRectGetMinY(moveGroup) + 0.48195 * CGRectGetHeight(moveGroup))];
                [bezier4Path closePath];
                [fillColor setFill];
                [bezier4Path fill];
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(moveGroup) + floor(CGRectGetWidth(moveGroup) * 0.41592 + 0.03) + 0.47, CGRectGetMinY(moveGroup) + floor(CGRectGetHeight(moveGroup) * 0.41479 + 0.15) + 0.35, floor(CGRectGetWidth(moveGroup) * 0.58367 - 0.47) - floor(CGRectGetWidth(moveGroup) * 0.41592 + 0.03) + 0.5, floor(CGRectGetHeight(moveGroup) * 0.58565 + 0.4) - floor(CGRectGetHeight(moveGroup) * 0.41479 + 0.15) - 0.25)];
                [fillColor setFill];
                [rectanglePath fill];
            }
        };
    }
    
    return self;
}

@end
