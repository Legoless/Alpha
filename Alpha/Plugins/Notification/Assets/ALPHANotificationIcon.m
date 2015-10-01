//
//  ALPHANotificationIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHANotificationIcon.h"

NSString *const ALPHAIconNotificationIdentifier = @"com.unifiedsense.alpha.icon.notification";

@implementation ALPHANotificationIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconNotificationIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect notificationGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame) - (0.05 * size.width), CGRectGetHeight(frame));
            
            
            //// Notification Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.96984 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.82857 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 1.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.79979 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.98642 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.82857 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 1.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.81562 * CGRectGetHeight(notificationGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 1.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.75378 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.97703 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.70636 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 1.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.73793 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.98962 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.71659 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.76538 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.29205 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.97703 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.70636 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.78017 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.54666 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.49999 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.00007 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.74767 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + -0.01244 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.58465 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.00007 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.23460 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.29205 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.41533 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.00007 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.25233 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + -0.01244 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.02296 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.70636 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.21978 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.54666 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.02296 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.70636 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.75378 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.01035 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.71660 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.73794 * CGRectGetHeight(notificationGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.79979 * CGRectGetHeight(notificationGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.03015 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.82857 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.00000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.81562 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.01356 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.82857 * CGRectGetHeight(notificationGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.96984 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.82857 * CGRectGetHeight(notificationGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.38000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.88586 * CGRectGetHeight(notificationGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.47999 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 1.00000 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.38000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.93839 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.42498 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 1.00000 * CGRectGetHeight(notificationGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.52000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 1.00000 * CGRectGetHeight(notificationGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.61999 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.88586 * CGRectGetHeight(notificationGroup)) controlPoint1: CGPointMake(CGRectGetMinX(notificationGroup) + 0.57501 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 1.00000 * CGRectGetHeight(notificationGroup)) controlPoint2: CGPointMake(CGRectGetMinX(notificationGroup) + 0.61999 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.93839 * CGRectGetHeight(notificationGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(notificationGroup) + 0.38000 * CGRectGetWidth(notificationGroup), CGRectGetMinY(notificationGroup) + 0.88586 * CGRectGetHeight(notificationGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
            }
        };
    }
    
    return self;
}

@end
