//
//  ALPHACoreAssets.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHACoreAssets.h"

NSString *const ALPHAIconDragHandleIdentifier = @"com.unifiedsense.alpha.icon.dragHandle";

@implementation ALPHADragHandleIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconDragHandleIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(8.0, 37.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect handleGroup = CGRectMake(CGRectGetMinX(frame) + 0.03, CGRectGetMinY(frame) - 0.06, CGRectGetWidth(frame) + 0.05, CGRectGetHeight(frame) + 0.18);

            //// Handle Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.05508 * CGRectGetHeight(handleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.05508 * CGRectGetHeight(handleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.03012 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.05508 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.04385 * CGRectGetHeight(handleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.02496 * CGRectGetHeight(handleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.00000 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.01123 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.00000 * CGRectGetHeight(handleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.00000 * CGRectGetHeight(handleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.02496 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.00000 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.01123 * CGRectGetHeight(handleGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.03012 * CGRectGetHeight(handleGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.05508 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.04385 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.05508 * CGRectGetHeight(handleGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.16007 * CGRectGetHeight(handleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.16007 * CGRectGetHeight(handleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.13511 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.16007 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.14884 * CGRectGetHeight(handleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.12995 * CGRectGetHeight(handleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.10499 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.11622 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.10499 * CGRectGetHeight(handleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.10499 * CGRectGetHeight(handleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.12995 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.10499 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.11622 * CGRectGetHeight(handleGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.13511 * CGRectGetHeight(handleGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.16007 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.14884 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.16007 * CGRectGetHeight(handleGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(handleGroup) + floor(CGRectGetWidth(handleGroup) * 0.00000 + 0.5), CGRectGetMinY(handleGroup) + floor(CGRectGetHeight(handleGroup) * 0.20868 - 0.48) + 0.98, floor(CGRectGetWidth(handleGroup) * 1.00000 + 0.45) - floor(CGRectGetWidth(handleGroup) * 0.00000 + 0.5) + 0.05, floor(CGRectGetHeight(handleGroup) * 0.26221 - 0.38) - floor(CGRectGetHeight(handleGroup) * 0.20868 - 0.48) - 0.1) cornerRadius: 1.45];
                [fillColor setFill];
                [rectanglePath fill];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.37005 * CGRectGetHeight(handleGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.37005 * CGRectGetHeight(handleGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.34509 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.37005 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.35882 * CGRectGetHeight(handleGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.33994 * CGRectGetHeight(handleGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.31497 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.32621 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.31497 * CGRectGetHeight(handleGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.31497 * CGRectGetHeight(handleGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.33994 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.31497 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.32621 * CGRectGetHeight(handleGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.34509 * CGRectGetHeight(handleGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.37005 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.35882 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.37005 * CGRectGetHeight(handleGroup))];
                [bezier3Path closePath];
                [fillColor setFill];
                [bezier3Path fill];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
                [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.47504 * CGRectGetHeight(handleGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.47504 * CGRectGetHeight(handleGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.45008 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.47504 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.46381 * CGRectGetHeight(handleGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.44493 * CGRectGetHeight(handleGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.41996 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.43120 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.41996 * CGRectGetHeight(handleGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.41996 * CGRectGetHeight(handleGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.44493 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.41996 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.43120 * CGRectGetHeight(handleGroup))];
                [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.45008 * CGRectGetHeight(handleGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.47504 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.46381 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.47504 * CGRectGetHeight(handleGroup))];
                [bezier4Path closePath];
                [fillColor setFill];
                [bezier4Path fill];
                
                
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = UIBezierPath.bezierPath;
                [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.58004 * CGRectGetHeight(handleGroup))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.58004 * CGRectGetHeight(handleGroup))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.55507 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.58004 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.56880 * CGRectGetHeight(handleGroup))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.54992 * CGRectGetHeight(handleGroup))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.52496 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.53619 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.52496 * CGRectGetHeight(handleGroup))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.52496 * CGRectGetHeight(handleGroup))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.54992 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.52496 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.53619 * CGRectGetHeight(handleGroup))];
                [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.55507 * CGRectGetHeight(handleGroup))];
                [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.58004 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.56880 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.58004 * CGRectGetHeight(handleGroup))];
                [bezier5Path closePath];
                [fillColor setFill];
                [bezier5Path fill];
                
                
                //// Bezier 6 Drawing
                UIBezierPath* bezier6Path = UIBezierPath.bezierPath;
                [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.68503 * CGRectGetHeight(handleGroup))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.68503 * CGRectGetHeight(handleGroup))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.66006 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.68503 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.67379 * CGRectGetHeight(handleGroup))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.65491 * CGRectGetHeight(handleGroup))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.62995 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.64118 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.62995 * CGRectGetHeight(handleGroup))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.62995 * CGRectGetHeight(handleGroup))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.65491 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.62995 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.64118 * CGRectGetHeight(handleGroup))];
                [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.66006 * CGRectGetHeight(handleGroup))];
                [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.68503 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.67379 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.68503 * CGRectGetHeight(handleGroup))];
                [bezier6Path closePath];
                [fillColor setFill];
                [bezier6Path fill];
                
                
                //// Bezier 7 Drawing
                UIBezierPath* bezier7Path = UIBezierPath.bezierPath;
                [bezier7Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.79002 * CGRectGetHeight(handleGroup))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.79002 * CGRectGetHeight(handleGroup))];
                [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.76505 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.79002 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.77879 * CGRectGetHeight(handleGroup))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.75990 * CGRectGetHeight(handleGroup))];
                [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.73494 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.74617 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.73494 * CGRectGetHeight(handleGroup))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.73494 * CGRectGetHeight(handleGroup))];
                [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.75990 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.73494 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.74617 * CGRectGetHeight(handleGroup))];
                [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.76505 * CGRectGetHeight(handleGroup))];
                [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.79002 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.77879 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.79002 * CGRectGetHeight(handleGroup))];
                [bezier7Path closePath];
                [fillColor setFill];
                [bezier7Path fill];
                
                
                //// Bezier 8 Drawing
                UIBezierPath* bezier8Path = UIBezierPath.bezierPath;
                [bezier8Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.89501 * CGRectGetHeight(handleGroup))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.89501 * CGRectGetHeight(handleGroup))];
                [bezier8Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.87005 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.89501 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.88378 * CGRectGetHeight(handleGroup))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.86489 * CGRectGetHeight(handleGroup))];
                [bezier8Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.83993 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.85116 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.83993 * CGRectGetHeight(handleGroup))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.83993 * CGRectGetHeight(handleGroup))];
                [bezier8Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.86489 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.83993 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.85116 * CGRectGetHeight(handleGroup))];
                [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.87005 * CGRectGetHeight(handleGroup))];
                [bezier8Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.89501 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.88378 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.89501 * CGRectGetHeight(handleGroup))];
                [bezier8Path closePath];
                [fillColor setFill];
                [bezier8Path fill];
                
                
                //// Bezier 9 Drawing
                UIBezierPath* bezier9Path = UIBezierPath.bezierPath;
                [bezier9Path moveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 1.00000 * CGRectGetHeight(handleGroup))];
                [bezier9Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 1.00000 * CGRectGetHeight(handleGroup))];
                [bezier9Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.97504 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 1.00000 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.98877 * CGRectGetHeight(handleGroup))];
                [bezier9Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.96988 * CGRectGetHeight(handleGroup))];
                [bezier9Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.11564 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.94492 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.00011 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.95615 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.05209 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.94492 * CGRectGetHeight(handleGroup))];
                [bezier9Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.94492 * CGRectGetHeight(handleGroup))];
                [bezier9Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.96988 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.94492 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.95615 * CGRectGetHeight(handleGroup))];
                [bezier9Path addLineToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.97504 * CGRectGetHeight(handleGroup))];
                [bezier9Path addCurveToPoint: CGPointMake(CGRectGetMinX(handleGroup) + 0.88392 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 1.00000 * CGRectGetHeight(handleGroup)) controlPoint1: CGPointMake(CGRectGetMinX(handleGroup) + 0.99945 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 0.98877 * CGRectGetHeight(handleGroup)) controlPoint2: CGPointMake(CGRectGetMinX(handleGroup) + 0.94747 * CGRectGetWidth(handleGroup), CGRectGetMinY(handleGroup) + 1.00000 * CGRectGetHeight(handleGroup))];
                [bezier9Path closePath];
                [fillColor setFill];
                [bezier9Path fill];
            }
        };
    }
    
    return self;
}

@end
