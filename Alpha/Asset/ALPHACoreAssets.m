//
//  ALPHACoreAssets.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHACoreAssets.h"

NSString *const ALPHAIconDragHandleIdentifier   = @"com.unifiedsense.alpha.icon.dragHandle";
NSString *const ALPHAIconInfoIdentifier         = @"com.unifiedsense.alpha.icon.info";
NSString *const ALPHAIconCloseIdentifier        = @"com.unifiedsense.alpha.icon.close";
NSString *const ALPHAIconMenuIdentifier         = @"com.unifiedsense.alpha.icon.menu";
NSString *const ALPHAIconRemoteIdentifier       = @"com.unifiedsense.alpha.icon.remote";
NSString *const ALPHALogoIdentifier             = @"com.unifiedsense.alpha.logo";

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
            CGRect handleGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));

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

@implementation ALPHAInfoIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconInfoIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            UIColor *strokeColor = fillColor;
            
            CGRect frame = { CGPointZero, size };

            //// Subframes
            CGRect infoGroup = CGRectMake(CGRectGetMinX(frame) + (size.width * 0.0725), CGRectGetMinY(frame) + (0.05 * size.height), CGRectGetWidth(frame) - (0.1375 * size.width), CGRectGetHeight(frame) - (0.1125 * size.height));
            
            //// Info Group
            {
                //// Oval Drawing
                UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.40870 + 0.3) + 0.2, CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.11268 + 0.1) + 0.4, floor(CGRectGetWidth(infoGroup) * 0.57681 - 0.3) - floor(CGRectGetWidth(infoGroup) * 0.40870 + 0.3) + 0.6, floor(CGRectGetHeight(infoGroup) * 0.27606 + 0.5) - floor(CGRectGetHeight(infoGroup) * 0.11268 + 0.1) - 0.4)];
                [fillColor setFill];
                [ovalPath fill];
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.42029 + 0.5), CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.32394 + 0.5), floor(CGRectGetWidth(infoGroup) * 0.57971 + 0.5) - floor(CGRectGetWidth(infoGroup) * 0.42029 + 0.5), floor(CGRectGetHeight(infoGroup) * 0.88732 + 0.5) - floor(CGRectGetHeight(infoGroup) * 0.32394 + 0.5)) cornerRadius: 5.5];
                [fillColor setFill];
                [rectanglePath fill];
                
                
                //// Rectangle 2 Drawing
                UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.34022 + 0.03) + 0.47, CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.32430 + 0.17) + 0.33, floor(CGRectGetWidth(infoGroup) * 0.58007 + 0.47) - floor(CGRectGetWidth(infoGroup) * 0.34022 + 0.03) - 0.45, floor(CGRectGetHeight(infoGroup) * 0.43204 - 0.48) - floor(CGRectGetHeight(infoGroup) * 0.32430 + 0.17) + 0.65) cornerRadius: 3.83];
                [fillColor setFill];
                [rectangle2Path fill];
                
                
                //// Oval 2 Drawing
                UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.00000 + 0.5), CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.00000 + 0.5), floor(CGRectGetWidth(infoGroup) * 1.00000 + 0.5) - floor(CGRectGetWidth(infoGroup) * 0.00000 + 0.5), floor(CGRectGetHeight(infoGroup) * 1.00000 + 0.5) - floor(CGRectGetHeight(infoGroup) * 0.00000 + 0.5))];
                [strokeColor setStroke];
                oval2Path.lineWidth = 4;
                [oval2Path stroke];
            }
        };
    }
    
    return self;
}

@end


@implementation ALPHACloseIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconCloseIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            frame = CGRectInset(frame, size.width * 0.15, size.height * 0.15);
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59166 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50150 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.96640 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87708 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97990 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95561 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98891 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89984 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99341 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92602 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.91576 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.96640 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98521 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.94502 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86512 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97610 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.89775 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.88087 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99204 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49375 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60052 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97610 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.07174 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.10663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99204 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.08975 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00760 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95561 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04248 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.02110 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98521 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02110 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87708 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00591 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92602 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.00141 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89984 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.39247 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50150 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02110 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12250 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00422 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05421 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00084 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10201 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.00478 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.07925 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.05317 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00641 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01322 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02917 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.02954 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01324 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02348 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.07681 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00042 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.09988 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00527 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49375 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39907 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86512 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02348 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.96133 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02519 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.89663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00839 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.92870 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00782 * CGRectGetHeight(frame))];
            [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.96302 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.99397 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05820 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99453 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09063 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59166 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50150 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [fillColor setFill];
            [bezierPath fill];

        };
    }
    
    return self;
}

@end

@implementation ALPHAMenuIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconMenuIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect mainMenuGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (0.133375 * size.height), CGRectGetWidth(frame), CGRectGetHeight(frame) - (0.265625 * size.height));
            
            //// MainMenu Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.19613 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.07037 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.19613 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.09806 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.03167 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.19613 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.15200 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.09806 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.07037 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.00000 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.04413 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.03167 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.00000 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.00000 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.09806 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.96833 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.00000 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.04413 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.09806 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.19613 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.15200 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.96833 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.19613 * CGRectGetHeight(mainMenuGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.59806 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.07037 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.59806 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.50000 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.03167 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.59806 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.55394 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.50000 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.07037 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.40194 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.44606 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.03167 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.40194 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.40194 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.50000 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.96833 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.40194 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.44606 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.50000 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.59806 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.55394 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.96833 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.59806 * CGRectGetHeight(mainMenuGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 1.00000 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.07037 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 1.00000 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.90194 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.03167 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 1.00000 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.95587 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.90194 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.07037 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.80387 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.84800 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.03167 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.80387 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.80387 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.90194 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.96833 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.80387 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.84800 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.90194 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.92963 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 1.00000 * CGRectGetHeight(mainMenuGroup)) controlPoint1: CGPointMake(CGRectGetMinX(mainMenuGroup) + 1.00000 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 0.95587 * CGRectGetHeight(mainMenuGroup)) controlPoint2: CGPointMake(CGRectGetMinX(mainMenuGroup) + 0.96833 * CGRectGetWidth(mainMenuGroup), CGRectGetMinY(mainMenuGroup) + 1.00000 * CGRectGetHeight(mainMenuGroup))];
                [bezier3Path closePath];
                [fillColor setFill];
                [bezier3Path fill];
            }
        };
    }
    
    return self;
}

@end

@implementation ALPHARemoteIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconRemoteIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            
            //// Subframes
            CGRect bonjourGroup = CGRectMake(CGRectGetMinX(frame) + (0.0375 * size.width), CGRectGetMinY(frame) + (0.125 * size.height), CGRectGetWidth(frame) - (0.0625 * size.width), CGRectGetHeight(frame) - (0.25 * size.height));
            
            
            //// Bonjour Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.45313 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.00221 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.98754 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.25526 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.64840 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + -0.01590 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.84818 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.07814 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.98415 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.34395 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 1.00580 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.27945 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 1.00342 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.32178 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.91277 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.34512 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.96646 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.37080 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.93103 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.37127 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.45995 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.13339 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.79355 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.19739 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.62523 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.11750 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.09001 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.34281 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.32265 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.14476 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.18964 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.22089 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.05681 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.36486 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.08115 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.35447 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.06984 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.36404 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.00103 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.28479 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.02417 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.36979 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + -0.00601 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.32588 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.01880 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.24793 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.00302 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.27004 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.01038 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.25775 * CGRectGetHeight(bonjourGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.45313 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.00221 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.13544 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.10417 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.29203 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.01588 * CGRectGetHeight(bonjourGroup))];
                [bezierPath closePath];
                [fillColor setFill];
                [bezierPath fill];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
                [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.44830 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.24868 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.85910 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.43631 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.59790 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.22774 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.75324 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.29872 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.85520 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.52226 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.87564 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.46064 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.87358 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.50041 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.78565 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.52769 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.83844 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.54867 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.80464 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.55164 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.53122 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.37813 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.71787 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.44168 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.62624 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.38707 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.21578 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.52681 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.41583 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.36581 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.29794 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.42216 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.14449 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.52223 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.19684 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.55258 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.16155 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.54965 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.14224 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.43540 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.12611 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.49990 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.12459 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.45905 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.44830 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.24868 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.22366 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.33053 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.33377 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.26381 * CGRectGetHeight(bonjourGroup))];
                [bezier2Path closePath];
                [fillColor setFill];
                [bezier2Path fill];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.47041 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.49188 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.72810 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.61434 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.56481 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.47981 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.66241 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.52634 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.72506 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.70222 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.74609 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.63844 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.74401 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.67992 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.65468 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.70570 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.70786 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.72894 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.67338 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.73074 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.51326 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.62211 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.61765 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.65677 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.56636 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.62584 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.34921 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.70174 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.45299 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.61658 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.39200 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.64723 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.30705 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.72389 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.33868 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.71697 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.32305 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.72632 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.26970 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.61839 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.26989 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.72054 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.24410 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.65670 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.47041 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.49188 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.32138 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.54624 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.39478 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.50154 * CGRectGetHeight(bonjourGroup))];
                [bezier3Path closePath];
                [fillColor setFill];
                [bezier3Path fill];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
                [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.48496 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.71896 * CGRectGetHeight(bonjourGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.60950 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.84989 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.54580 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.70582 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.60754 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.77048 * CGRectGetHeight(bonjourGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.50104 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.99993 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.61515 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.92775 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.56175 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 1.00163 * CGRectGetHeight(bonjourGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.39110 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.87421 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.44646 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 1.00236 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.39588 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.94408 * CGRectGetHeight(bonjourGroup))];
                [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.48496 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.71896 * CGRectGetHeight(bonjourGroup)) controlPoint1: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.38332 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.80086 * CGRectGetHeight(bonjourGroup)) controlPoint2: CGPointMake(CGRectGetMinX(bonjourGroup) + 0.42788 * CGRectGetWidth(bonjourGroup), CGRectGetMinY(bonjourGroup) + 0.72742 * CGRectGetHeight(bonjourGroup))];
                [bezier4Path closePath];
                [fillColor setFill];
                [bezier4Path fill];
            }

        };
    }
    
    return self;
}

@end

@implementation ALPHALogoAsset

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHALogoIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            UIColor *strokeColor = fillColor;
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect alphaGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
            
            
            //// Alpha Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = UIBezierPath.bezierPath;
                [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.00000 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.56225 * CGRectGetHeight(alphaGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.21176 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.56301 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.21508 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.56513 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.21318 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.56301 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.21448 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.56384 * CGRectGetHeight(alphaGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.24234 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.62346 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.24892 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.62365 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.24360 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.62617 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.24745 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.62624 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.30985 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.48147 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.27903 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.57083 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.28871 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.53335 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.31682 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.48175 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.31117 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.47823 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.31588 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.47838 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.35577 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.65905 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.33178 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.53581 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.34329 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.60272 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.36295 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.65912 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.35659 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.66277 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.36188 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.66280 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.48598 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.15219 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.41340 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.48631 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.44461 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.32553 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.49318 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.15258 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.48694 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.14816 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.49274 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.14845 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.61399 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.99692 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.52358 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.43522 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.56389 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.71689 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.62107 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.99778 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.61464 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 1.00055 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.61962 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 1.00114 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.78553 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.55663 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.68508 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.84783 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.73767 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.68766 * CGRectGetHeight(alphaGroup))];
                [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 0.78915 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.55424 * CGRectGetHeight(alphaGroup)) controlPoint1: CGPointMake(CGRectGetMinX(alphaGroup) + 0.78609 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.55510 * CGRectGetHeight(alphaGroup)) controlPoint2: CGPointMake(CGRectGetMinX(alphaGroup) + 0.78755 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.55415 * CGRectGetHeight(alphaGroup))];
                [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(alphaGroup) + 1.00000 * CGRectGetWidth(alphaGroup), CGRectGetMinY(alphaGroup) + 0.56448 * CGRectGetHeight(alphaGroup))];
                bezierPath.lineCapStyle = kCGLineCapRound;
                
                [strokeColor setStroke];
                bezierPath.lineWidth = 3 * (size.width / 80.0);
                [bezierPath stroke];
                
                //// Oval 4 Drawing
                UIBezierPath* oval4Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(alphaGroup) + floor(CGRectGetWidth(alphaGroup) * 0.45314 + 0.05) + 0.45, CGRectGetMinY(alphaGroup) + floor(CGRectGetHeight(alphaGroup) * 0.00000 - 0.15) + 0.65, floor(CGRectGetWidth(alphaGroup) * 0.51530 + 0.05) - floor(CGRectGetWidth(alphaGroup) * 0.45314 + 0.05), floor(CGRectGetHeight(alphaGroup) * 0.06278 - 0.15) - floor(CGRectGetHeight(alphaGroup) * 0.00000 - 0.15))];
                [fillColor setFill];
                [oval4Path fill];
            }

        };
    }
    
    return self;
}

@end

