//
//  ALPHACanvasView.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHACanvasView.h"

@implementation ALPHACanvasView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.shouldReceiveTouches = YES;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.shouldReceiveTouches = YES;
}

- (id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id hitView = [super hitTest:point withEvent:event];
    
    if ( (hitView == self) && !self.shouldReceiveTouches)
    {
        return nil;
    }
    else
    {
        return hitView;
    }
}
@end
