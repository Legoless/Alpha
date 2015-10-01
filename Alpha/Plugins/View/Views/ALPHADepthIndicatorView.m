//
//  ALPHADepthIndicatorView.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADepthIndicatorView.h"

@implementation ALPHADepthIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.depthIndicatorWidth = 4.0;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSUInteger count = (NSUInteger)(rect.size.width / self.depthIndicatorWidth);
    
    [self.tintColor setStroke];
    
    const CGFloat lineWidth = .5;
    
    // We need offset for line renderer to avoid halfline loss.
    // In iOS system path stroking from the middle of path so the real line width will take
    // coordinates: [x-lineWidth/2;x+lineWidth/2]. If we will stroke from x = 0 point
    // the left part of line will lost.
    CGFloat halfLineOffset = MAX(lineWidth/2,1/[UIScreen mainScreen].scale);
    for (NSUInteger i = 0; i < count; i++)
    {
        CGFloat x = i * self.depthIndicatorWidth+halfLineOffset;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, 0.0)];
        [path addLineToPoint:CGPointMake(x, rect.size.height)];
        path.lineWidth = lineWidth;
        
        [path stroke];
    }
}

@end
