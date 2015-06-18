//
//  ALPHANetworkIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHANetworkIcon.h"

NSString *const ALPHAIconNetworkIdentifier = @"com.unifiedsense.alpha.icon.network";

@implementation ALPHANetworkIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconNetworkIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(40.0, 40.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect networkGroup = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 80.4) * 0.00000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 73.7) * 0.50000 + 0.35) + 0.15, 80.4, 73.7);
            
            
            //// Network Group
            {
                //// Oval Drawing
                UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(networkGroup) + 19.5, CGRectGetMinY(networkGroup) + 18.85, 34, 32)];
                [fillColor setFill];
                [ovalPath fill];
                
                
                //// Oval 2 Drawing
                UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(networkGroup) + 51.5, CGRectGetMinY(networkGroup) + 6.1, 10, 11)];
                [fillColor setFill];
                [oval2Path fill];
                
                
                //// Oval 3 Drawing
                UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(networkGroup) + 1.1, CGRectGetMinY(networkGroup), 16.8, 15.7)];
                [fillColor setFill];
                [oval3Path fill];
                
                
                //// Oval 4 Drawing
                UIBezierPath* oval4Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(networkGroup) + 64.6, CGRectGetMinY(networkGroup) + 43.25, 15.8, 14.7)];
                [fillColor setFill];
                [oval4Path fill];
                
                
                //// Oval 5 Drawing
                UIBezierPath* oval5Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(networkGroup) + 24.6, CGRectGetMinY(networkGroup) + 58, 15.8, 15.7)];
                [fillColor setFill];
                [oval5Path fill];
                
                
                //// Oval 6 Drawing
                UIBezierPath* oval6Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(networkGroup), CGRectGetMinY(networkGroup) + 40, 11, 10)];
                [fillColor setFill];
                [oval6Path fill];
                
                
                //// Rectangle Drawing
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, CGRectGetMinX(networkGroup) + 49.63, CGRectGetMinY(networkGroup) + 22.97);
                CGContextRotateCTM(context, 27.35 * M_PI / 180);
                
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(-1.04, -13.51, 2.08, 27.02)];
                [fillColor setFill];
                [rectanglePath fill];
                
                CGContextRestoreGState(context);
                
                
                //// Rectangle 2 Drawing
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, CGRectGetMinX(networkGroup) + 34.81, CGRectGetMinY(networkGroup) + 56.04);
                CGContextRotateCTM(context, 7.25 * M_PI / 180);
                
                UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(-0.95, -13.44, 1.9, 26.87)];
                [fillColor setFill];
                [rectangle2Path fill];
                
                CGContextRestoreGState(context);
                
                
                //// Rectangle 3 Drawing
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, CGRectGetMinX(networkGroup) + 55.25, CGRectGetMinY(networkGroup) + 43.33);
                CGContextRotateCTM(context, 23.45 * M_PI / 180);
                
                UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake(-13.72, -1.01, 27.44, 2.02)];
                [fillColor setFill];
                [rectangle3Path fill];
                
                CGContextRestoreGState(context);
                
                
                //// Rectangle 4 Drawing
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, CGRectGetMinX(networkGroup) + 20.62, CGRectGetMinY(networkGroup) + 41.49);
                CGContextRotateCTM(context, -8.9 * M_PI / 180);
                
                UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect: CGRectMake(-13.75, -0.83, 27.51, 1.67)];
                [fillColor setFill];
                [rectangle4Path fill];
                
                CGContextRestoreGState(context);
                
                
                //// Rectangle 5 Drawing
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, CGRectGetMinX(networkGroup) + 21.62, CGRectGetMinY(networkGroup) + 18.5);
                CGContextRotateCTM(context, 43.2 * M_PI / 180);
                
                UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRect: CGRectMake(-13.62, -1.06, 27.24, 2.13)];
                [fillColor setFill];
                [rectangle5Path fill];
                
                CGContextRestoreGState(context);
            }

        };
    }
    
    return self;
}

@end
