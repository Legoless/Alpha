//
//  ALPHAPermissionIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 02/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAPermissionIcon.h"

NSString *const ALPHAIconPermissionIdentifier = @"com.unifiedsense.alpha.icon.permission";

@implementation ALPHAPermissionIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconPermissionIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67868 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12076 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40149 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67868 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59851 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.67868 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12076 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67868 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51985 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75632 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51985 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48015 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48015 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75632 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44044 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45708 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74808 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.44044 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72608 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44044 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66684 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46712 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55956 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55956 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66684 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51985 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75632 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55956 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72608 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54292 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74808 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77794 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71838 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71838 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.71838 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09872 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62043 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28162 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37957 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.28162 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09872 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28162 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22206 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.18922 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50692 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22206 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97308 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.18922 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77794 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.81078 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97308 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77794 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50692 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.81078 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            bezierPath.usesEvenOddFillRule = YES;
            
            [fillColor setFill];
            [bezierPath fill];
        };
    }
    
    return self;
}


@end
