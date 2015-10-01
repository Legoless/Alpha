//
//  ALPHAEventIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEventIcon.h"

NSString *const ALPHAIconEventIdentifier   = @"com.unifiedsense.alpha.icon.event";

@implementation ALPHAEventIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconEventIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect group = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (0.075 * size.height), CGRectGetWidth(frame), CGRectGetHeight(frame) - (0.1375 * size.height));
            
            //// Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.03935 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.22210 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.05844 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.19363 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.03934 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.20645 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.04793 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.19364 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.94092 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.19264 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.96006 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.22108 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.95144 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.19263 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.96005 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.20543 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.96066 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.91551 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.94157 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.94398 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.96067 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.93116 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.95208 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.94397 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.05909 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.94496 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.03995 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.91653 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.04857 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.94498 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.03996 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.93218 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.03935 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.22210 * CGRectGetHeight(group))];
                [bezierPath closePath];
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.04248 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00000 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.95827 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.99898 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 1.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.93672 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.98125 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.99895 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 1.00003 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.97094 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.99936 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.19020 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.95752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.12804 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.99933 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.15598 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.98051 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.12802 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.04173 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.12906 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.19131 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.01875 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.12908 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + -0.00003 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.15710 * CGRectGetHeight(group))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.00064 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.93783 * CGRectGetHeight(group))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.04248 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00000 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.00067 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.97205 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.01949 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00003 * CGRectGetHeight(group))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.30378 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.22979 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.46133 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.19827 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.49725 * CGRectGetHeight(group))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.42058 * CGRectGetHeight(group))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.22979 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.38465 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.19827 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.30378 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.42058 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.33530 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.38465 * CGRectGetHeight(group))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.46133 * CGRectGetHeight(group))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.30378 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.49725 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.33530 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.53891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.78371 * CGRectGetHeight(group))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.46491 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.78371 * CGRectGetHeight(group))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.40761 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.71840 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.43339 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.78371 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.40761 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.75432 * CGRectGetHeight(group))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.40761 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.67765 * CGRectGetHeight(group))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.46491 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.61233 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.40761 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.64172 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.43339 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.61233 * CGRectGetHeight(group))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.53891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.61233 * CGRectGetHeight(group))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.59622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.67765 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.57043 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.61233 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.59622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.64172 * CGRectGetHeight(group))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.59622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.71840 * CGRectGetHeight(group))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.53891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.78371 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.59622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.75432 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.57043 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.78371 * CGRectGetHeight(group))];
                [bezier3Path closePath];
                [fillColor setFill];
                [bezier3Path fill];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
                [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.77021 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.69622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.46133 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.66470 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.49725 * CGRectGetHeight(group))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.42058 * CGRectGetHeight(group))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.69622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.38465 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.66470 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.77021 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.42058 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.80173 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35526 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.38465 * CGRectGetHeight(group))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.46133 * CGRectGetHeight(group))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.77021 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.49725 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.80173 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.52664 * CGRectGetHeight(group))];
                [bezier4Path closePath];
                [fillColor setFill];
                [bezier4Path fill];
                
                
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = UIBezierPath.bezierPath;
                [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.30378 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.22979 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.71404 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.19827 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.74997 * CGRectGetHeight(group))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.67329 * CGRectGetHeight(group))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.22979 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.17248 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.63737 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.19827 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.30378 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.67329 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.33530 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.63737 * CGRectGetHeight(group))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.71404 * CGRectGetHeight(group))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.30378 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.36109 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.74997 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.33530 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group))];
                [bezier5Path closePath];
                [fillColor setFill];
                [bezier5Path fill];
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.40717 + 0.17) + 0.33, CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.35281 - 0.48) + 0.98, floor(CGRectGetWidth(group) * 0.60240 - 0.33) - floor(CGRectGetWidth(group) * 0.40717 + 0.17) + 0.5, floor(CGRectGetHeight(group) * 0.52012 + 0.02) - floor(CGRectGetHeight(group) * 0.35281 - 0.48) - 0.5) cornerRadius: 5.75];
                [fillColor setFill];
                [rectanglePath fill];
                
                
                //// Bezier 6 Drawing
                UIBezierPath* bezier6Path = UIBezierPath.bezierPath;
                [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.77021 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.69622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.71404 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.66470 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.74997 * CGRectGetHeight(group))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.67329 * CGRectGetHeight(group))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.69622 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.63891 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.63737 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.66470 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.77021 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.67329 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.80173 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.60798 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.63737 * CGRectGetHeight(group))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.71404 * CGRectGetHeight(group))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.77021 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.82752 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.74997 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.80173 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.77936 * CGRectGetHeight(group))];
                [bezier6Path closePath];
                [fillColor setFill];
                [bezier6Path fill];
                
                
                //// Bezier 7 Drawing
                UIBezierPath* bezier7Path = UIBezierPath.bezierPath;
                [bezier7Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.35793 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.13240 * CGRectGetHeight(group))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.35793 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.05743 * CGRectGetHeight(group))];
                [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.30755 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.35793 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.02584 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.33526 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.27115 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
                [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.22077 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.05743 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.24344 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.22077 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.02584 * CGRectGetHeight(group))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.22077 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.12921 * CGRectGetHeight(group))];
                [fillColor setFill];
                [bezier7Path fill];
                
                
                //// Bezier 8 Drawing
                UIBezierPath* bezier8Path = UIBezierPath.bezierPath;
                [bezier8Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.77644 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.13240 * CGRectGetHeight(group))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.77644 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.05743 * CGRectGetHeight(group))];
                [bezier8Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.72605 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.77644 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.02584 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.75376 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.68966 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
                [bezier8Path addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.63927 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.05743 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.66194 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.63927 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.02584 * CGRectGetHeight(group))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.63927 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.12921 * CGRectGetHeight(group))];
                [fillColor setFill];
                [bezier8Path fill];
            }
        };
    }
    
    return self;
}

@end
