//
//  ALPHAViewIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAViewIcon.h"

NSString *const ALPHAIconViewIdentifier = @"com.unifiedsense.alpha.icon.view";

@implementation ALPHAViewIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconViewIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect viewInspectionGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (0.15 * size.height), CGRectGetWidth(frame), CGRectGetHeight(frame) - (0.2875 * size.height));
            
            //// ViewInspection Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50208 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.43987 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50404 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.34285 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.49197 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.40901 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.49352 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.37405 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.34254 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50269 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.34277 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50136 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.34254 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.39103 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.43975 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.34254 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.39103 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.41621 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.65746 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.39103 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.58748 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.43975 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.65746 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.61025 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.55898 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.65746 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.61025 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.58748 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.61011 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.49695 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.61025 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.49959 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.61013 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.49828 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50208 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.43987 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.56560 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.51605 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.51953 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.49319 * CGRectGetHeight(viewInspectionGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.85267 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.25513 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.36539 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.85267 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.25513 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.69429 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.14917 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.25513 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.30755 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.36539 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.14917 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.74487 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.63461 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.14917 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.74487 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.30755 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.85267 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.74487 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.69429 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.63461 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.85267 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path closePath];
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.00000 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.00000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.20128 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.00000 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.00000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 1.00000 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.00000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.20128 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 1.00000 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 1.00000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.79872 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 1.00000 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 1.00000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.50000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.00000 * CGRectGetHeight(viewInspectionGroup)) controlPoint1: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 1.00000 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.50092 * CGRectGetHeight(viewInspectionGroup)) controlPoint2: CGPointMake(CGRectGetMinX(viewInspectionGroup) + 0.79872 * CGRectGetWidth(viewInspectionGroup), CGRectGetMinY(viewInspectionGroup) + 0.00000 * CGRectGetHeight(viewInspectionGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
            }
        };
    }
    
    return self;
}

@end
