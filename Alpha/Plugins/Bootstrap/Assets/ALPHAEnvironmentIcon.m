//
//  ALPHAEnvironmentIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEnvironmentIcon.h"

NSString *const ALPHAIconEnvironmentIdentifier = @"com.unifiedsense.alpha.icon.environment";

@implementation ALPHAEnvironmentIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconEnvironmentIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(40.0, 40.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect enviromentGroup = CGRectMake(CGRectGetMinX(frame) + 12.3, CGRectGetMinY(frame) - 0.06, CGRectGetWidth(frame) - 24.85, CGRectGetHeight(frame) + 0.24);
            
            //// enviroment Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00000 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.40460 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.61621 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.68819 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00714 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.48598 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.35857 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.76061 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.63346 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.67533 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.62553 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.68556 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.63406 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.68215 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.62262 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.55170 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.65242 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.54190 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.62168 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.54090 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.64048 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.53471 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.99397 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.74735 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.99547 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.76450 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 1.00138 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.75180 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 1.00205 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.75948 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.69223 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.99590 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.66093 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.98856 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.68162 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 1.00399 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.66187 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.99936 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.65005 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.86460 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.63167 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.85322 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.64948 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.85806 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.64134 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.85346 * CGRectGetHeight(enviromentGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00000 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.40460 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.22595 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.84289 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.01961 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.62830 * CGRectGetHeight(enviromentGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.99735 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.60002 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.38541 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.31223 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.99143 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.51860 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.64411 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.24157 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.36796 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.32497 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.37604 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.31478 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.36746 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.31814 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.37695 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.44867 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.34701 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.45826 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.37774 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.45947 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.35884 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.46553 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00854 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.25048 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00730 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.23332 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00121 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.24598 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.00065 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.23830 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.31398 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.00401 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.34517 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.01157 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.32471 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + -0.00401 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.34439 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.00076 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.35419 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.13559 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.37241 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.14710 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.35467 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.14214 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.36274 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.14679 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.99735 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.60002 * CGRectGetHeight(enviromentGroup)) controlPoint1: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.77795 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.16020 * CGRectGetHeight(enviromentGroup)) controlPoint2: CGPointMake(CGRectGetMinX(enviromentGroup) + 0.98108 * CGRectGetWidth(enviromentGroup), CGRectGetMinY(enviromentGroup) + 0.37620 * CGRectGetHeight(enviromentGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
            }
        };
    }
    
    return self;
}

@end
