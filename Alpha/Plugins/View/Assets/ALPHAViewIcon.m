//
//  ALPHAViewIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAViewIcon.h"

NSString *const ALPHAIconViewIdentifier = @"com.unifiedsense.alpha.icon.view";

@implementation ALPHAViewIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconViewIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(40.0, 40.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            UIColor *strokeColor = fillColor;
            
            CGRect frame = { CGPointZero, size };
            
            //// Subframes
            CGRect infoGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
            
            //// Info Group
            {
                //// Oval Drawing
                UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.40250 + 0.3) + 0.2, CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.10000 + 0.1) + 0.4, floor(CGRectGetWidth(infoGroup) * 0.57250 - 0.3) - floor(CGRectGetWidth(infoGroup) * 0.40250 + 0.3) + 0.6, floor(CGRectGetHeight(infoGroup) * 0.29500 + 0.5) - floor(CGRectGetHeight(infoGroup) * 0.10000 + 0.1) - 0.4)];
                [fillColor setFill];
                [ovalPath fill];
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.42500 + 0.5), CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.32500 + 0.5), floor(CGRectGetWidth(infoGroup) * 0.57500 + 0.5) - floor(CGRectGetWidth(infoGroup) * 0.42500 + 0.5), floor(CGRectGetHeight(infoGroup) * 0.90000 + 0.5) - floor(CGRectGetHeight(infoGroup) * 0.32500 + 0.5)) cornerRadius: 6];
                [fillColor setFill];
                [rectanglePath fill];
                
                
                //// Rectangle 2 Drawing
                UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(infoGroup) + floor(CGRectGetWidth(infoGroup) * 0.33094 + 0.03) + 0.47, CGRectGetMinY(infoGroup) + floor(CGRectGetHeight(infoGroup) * 0.32531 + 0.17) + 0.33, floor(CGRectGetWidth(infoGroup) * 0.57531 + 0.47) - floor(CGRectGetWidth(infoGroup) * 0.33094 + 0.03) - 0.45, floor(CGRectGetHeight(infoGroup) * 0.42094 - 0.48) - floor(CGRectGetHeight(infoGroup) * 0.32531 + 0.17) + 0.65) cornerRadius: 3.83];
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
