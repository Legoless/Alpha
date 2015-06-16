//
//  ALPHADepthIndicatorView.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADepthIndicatorView.h"

@implementation ALPHADepthIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.depthIndicatorWidth = 4.0;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSUInteger count = (NSUInteger)(rect.size.width / self.depthIndicatorWidth);
    
    [self.tintColor setStroke];
    
    for (NSUInteger i = 0; i < count; i++)
    {
        CGFloat x = i * self.depthIndicatorWidth;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, 0.0)];
        [path addLineToPoint:CGPointMake(x, rect.size.height)];
        path.lineWidth = 0.5;
        
        [path stroke];
    }
}

@end
