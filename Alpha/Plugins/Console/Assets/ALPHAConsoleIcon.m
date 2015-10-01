//
//  ALPHAConsoleIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAConsoleIcon.h"

NSString *const ALPHAIconConsoleIdentifier = @"com.unifiedsense.alpha.icon.console";

@implementation ALPHAConsoleIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconConsoleIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect consoleGroup = CGRectMake(CGRectGetMinX(frame) - (0.004125 * size.width), CGRectGetMinY(frame) + (0.12 * size.height), CGRectGetWidth(frame) + (0.003125 * size.width), CGRectGetHeight(frame) - (0.23925 * size.height));
            
            //// Console Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.09989 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.00000 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.14416 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.02375 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.11727 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.00000 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.13203 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.00792 * CGRectGetHeight(consoleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.46434 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.44163 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.48303 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.50004 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.47680 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.45789 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.48303 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.47736 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.46433 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.55780 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.48303 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.52314 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.47679 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.54240 * CGRectGetHeight(consoleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.14411 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.97561 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.09984 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.13231 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.99187 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.11755 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.05509 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.97561 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.08246 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.06754 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.99186 * CGRectGetHeight(consoleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.01820 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.92811 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.86969 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00606 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.91142 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.89195 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.01820 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.81193 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.84702 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00607 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.82776 * CGRectGetHeight(consoleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.25726 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.50001 * CGRectGetHeight(consoleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.01823 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.18805 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00004 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.13029 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00610 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.17222 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00004 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.15296 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.01824 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.07188 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00004 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.10803 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.00611 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.08856 * CGRectGetHeight(consoleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.05513 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.02374 * CGRectGetHeight(consoleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.09989 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.00000 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.06792 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.00791 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.08284 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.00000 * CGRectGetHeight(consoleGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.94625 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.60654 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.55279 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.92632 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.57698 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.55279 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.96684 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.55279 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.92018 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.60654 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.84650 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.55279 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.87965 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.57698 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.84650 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.94625 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.84650 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 1.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.92018 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 0.97581 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.84650 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 1.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.87965 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 1.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.92632 * CGRectGetHeight(consoleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(consoleGroup) + 0.94625 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(consoleGroup) + 1.00000 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 0.96684 * CGRectGetHeight(consoleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(consoleGroup) + 0.97581 * CGRectGetWidth(consoleGroup), CGRectGetMinY(consoleGroup) + 1.00000 * CGRectGetHeight(consoleGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
            }
        };
    }
    
    return self;
}

@end
