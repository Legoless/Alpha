//
//  ALPHAScreenshotIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenshotIcon.h"

NSString *const ALPHAIconScreenshotIdentifier = @"com.unifiedsense.alpha.icon.screenshot";

@implementation ALPHAScreenshotIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconScreenshotIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(40.0, 40.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
          
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect screenshotGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (0.1125 * size.height), CGRectGetWidth(frame), CGRectGetHeight(frame) - (0.2375 * size.height));
            
            //// Screenshot Group
            {
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(screenshotGroup) + floor(CGRectGetWidth(screenshotGroup) * 0.16410 + 0.4) + 0.1, CGRectGetMinY(screenshotGroup) + floor(CGRectGetHeight(screenshotGroup) * 0.18989 + 0.38) + 0.12, floor(CGRectGetWidth(screenshotGroup) * 0.85177 + 0.5) - floor(CGRectGetWidth(screenshotGroup) * 0.16410 + 0.4) - 0.1, floor(CGRectGetHeight(screenshotGroup) * 0.81772 + 0.08) - floor(CGRectGetHeight(screenshotGroup) * 0.18989 + 0.38) + 0.3) cornerRadius: 10.4];
                [fillColor setFill];
                [rectanglePath fill];
                
                
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08001 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.16627 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.13689 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.09066 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08001 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.12451 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.10547 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.09066 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.23714 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.09066 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.23714 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.00000 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08174 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.00000 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.10867 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.03660 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.00000 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.04866 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.22875 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08001 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.22875 * CGRectGetHeight(screenshotGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08001 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.16627 * CGRectGetHeight(screenshotGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.89132 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08174 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 1.00000 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.95135 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.03660 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 1.00000 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.23714 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 1.00000 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.23714 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.90935 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.13688 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.90935 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08002 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.83373 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.10547 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.90935 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08002 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.87549 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.08002 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.77875 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.77875 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.89132 * CGRectGetHeight(screenshotGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.10868 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.91826 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.00000 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.04866 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.96340 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.00000 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.76286 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.00000 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.76286 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.09065 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.86388 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.09065 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.16627 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.89528 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.09065 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.12451 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.22876 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.22876 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.10868 * CGRectGetHeight(screenshotGroup))];
                [bezier3Path closePath];
                [fillColor setFill];
                [bezier3Path fill];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
                [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.83373 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.86387 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.90935 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.87549 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.89529 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.90935 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.76286 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.90935 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.76286 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 1.00000 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.91826 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 1.00000 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.89133 * CGRectGetHeight(screenshotGroup)) controlPoint1: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.96340 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 1.00000 * CGRectGetHeight(screenshotGroup)) controlPoint2: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.95134 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 1.00000 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.77875 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.77875 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(screenshotGroup) + 0.92074 * CGRectGetWidth(screenshotGroup), CGRectGetMinY(screenshotGroup) + 0.83373 * CGRectGetHeight(screenshotGroup))];
                [bezier4Path closePath];
                [fillColor setFill];
                [bezier4Path fill];
            }
        };
    }
    
    return self;
}

@end
