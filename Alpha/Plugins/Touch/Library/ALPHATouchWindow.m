//
//  ALPHATouchWindow.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHATouchFingerView.h"
#import "ALPHATouchWindow.h"

static NSString* kALPHAFingerViewAssociatedKey = @"kALPHAFingerViewAssociatedKey";

@interface ALPHATouchWindow ()

@property (nonatomic, strong) UIView* touchesView;

@end

@implementation ALPHATouchWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Lets place this window above everything
        self.windowLevel = UIWindowLevelStatusBar + 10000.0;
        
        self.touchesView = [[UIView alloc] initWithFrame:frame];
        self.touchesView.userInteractionEnabled = NO;
        self.userInteractionEnabled = NO;
        
        [self addSubview:self.touchesView];
    }
    
    return self;
}

- (void)displayEvent:(UIEvent *)event
{
    NSSet *touches = [event allTouches];
    
    for (UITouch *touch in touches)
    {        
        if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded)
        {
            [self removeFingerViewForTouch:touch];
        }
        else
        {
            [self updateFingerViewForTouch:touch];
        }
    }
}

- (void)updateFingerViewForTouch:(UITouch *)touch
{
    void *key = (__bridge void *)kALPHAFingerViewAssociatedKey;
    
    ALPHATouchFingerView *fingerView = objc_getAssociatedObject(touch, key);
    
    CGPoint point = [touch locationInView:self.touchesView];
    
    if (!fingerView)
    {
        fingerView = [[ALPHATouchFingerView alloc] initWithPoint:point];
        
        objc_setAssociatedObject(touch, key, fingerView, OBJC_ASSOCIATION_ASSIGN);
        
        [self.touchesView addSubview:fingerView];
    }
    
    [fingerView updateWithTouch:touch];
}

- (void)removeFingerViewForTouch:(UITouch *)touch
{
    void *key = (__bridge void *) kALPHAFingerViewAssociatedKey;
    
    ALPHATouchFingerView * fingerView = objc_getAssociatedObject (touch, key);
    
    if (fingerView)
    {
        objc_setAssociatedObject(touch, key, nil, OBJC_ASSOCIATION_ASSIGN);
        
        [fingerView removeFromSuperview];
    }
}

@end
