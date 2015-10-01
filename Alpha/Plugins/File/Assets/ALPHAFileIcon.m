//
//  ALPHAFileIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFileIcon.h"

NSString *const ALPHAIconFileIdentifier = @"com.unifiedsense.alpha.icon.file";

@implementation ALPHAFileIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconFileIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65939 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24454 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65939 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09709 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30522 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80458 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30522 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80458 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90291 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.19542 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90291 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.19542 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09709 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09709 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50865 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50865 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43583 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43583 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50865 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64295 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64295 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57014 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57014 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64295 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77746 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77746 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70464 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70464 * CGRectGetHeight(frame))];
            [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77746 * CGRectGetHeight(frame))];
            [bezierPath closePath];
            [fillColor setFill];
            [bezierPath fill];
        };
    }
    
    return self;
}

@end
