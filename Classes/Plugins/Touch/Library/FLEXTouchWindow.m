//
//  FLEXTouchWindow.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@import ObjectiveC.runtime;

#import "FLEXTouchWindow.h"

@interface FLEXTouchView : UIView
@end

@implementation FLEXTouchView
@end

/*!
 * Touch finger view from Touchpose
 */
@interface FLEXTouchFingerView : UIView

- (id)initWithPoint:(CGPoint)point color:(UIColor *)color touchEndAnimationDuration:(NSTimeInterval)touchEndAnimationDuration touchEndTransform:(CATransform3D)touchEndTransform customTouchImage:(UIImage *)customTouchImage customTouchPoint:(CGPoint)customtouchPoint;

@end

@implementation FLEXTouchFingerView
{
    CATransform3D _touchEndTransform;
    CGFloat _touchEndAnimationDuration;
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"-[%@ %@] not supported", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)removeFromSuperview
{
    [UIView animateWithDuration:_touchEndAnimationDuration animations:^
    {
        self.alpha = 0.0f;
        self.layer.transform = _touchEndTransform;
    }
    completion:^(BOOL completed)
    {
        [super removeFromSuperview];
    }];
}

#pragma mark - QTouchposeFingerView

- (id)initWithPoint:(CGPoint)point color:(UIColor *)color touchEndAnimationDuration:(NSTimeInterval)touchEndAnimationDuration touchEndTransform:(CATransform3D)touchEndTransform customTouchImage:(UIImage *)customTouchImage customTouchPoint:(CGPoint)customtouchPoint

{
    if (customTouchImage)
    {
        CGRect frame = CGRectMake(point.x - customtouchPoint.x,
                                  point.y - customtouchPoint.y,
                                  customTouchImage.size.width,
                                  customTouchImage.size.height);
        
        if (self = [super initWithFrame:frame])
        {
            self.opaque = NO;
            
            UIImageView *iv = [[UIImageView alloc] initWithImage:customTouchImage];
            [self addSubview:iv];
        }
        
        return self;
    }
    else
    {
        const CGFloat kFingerRadius = 22.0f;
        
        if ((self = [super initWithFrame:CGRectMake(point.x - kFingerRadius, point.y - kFingerRadius, 2 * kFingerRadius, 2 * kFingerRadius)]))
        {
            self.opaque = NO;
            self.layer.borderColor = [color colorWithAlphaComponent:0.6f].CGColor;
            self.layer.cornerRadius = kFingerRadius;
            self.layer.borderWidth = 2.0f;
            self.layer.backgroundColor = [color colorWithAlphaComponent:0.4f].CGColor;
            
            _touchEndAnimationDuration = touchEndAnimationDuration;
            _touchEndTransform = touchEndTransform;
        }
        
        return self;
    }
}

@end

static NSString* kFLEXFingerViewAssociatedKey = @"kFingerViewForTouch";

@interface FLEXTouchWindow ()

@property (nonatomic, strong) FLEXTouchView* touchesView;

@end

@implementation FLEXTouchWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Lets place this window above everything
        self.windowLevel = UIWindowLevelStatusBar + 10000.0;
        
        self.touchesView = [[FLEXTouchView alloc] initWithFrame:frame];
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
    void *key = (__bridge void *)kFLEXFingerViewAssociatedKey;
    
    FLEXTouchFingerView* fingerView = objc_getAssociatedObject (touch, key);
    
    CGPoint point = [touch locationInView:self.touchesView];
    
    if (!fingerView)
    {
        fingerView = [[FLEXTouchFingerView alloc] initWithPoint:point color:[UIColor colorWithRed:0.251f green:0.424f blue:0.502f alpha:1.0f] touchEndAnimationDuration:0.5f touchEndTransform:CATransform3DMakeScale(1.5, 1.5, 1) customTouchImage:nil customTouchPoint:CGPointZero];
        
        objc_setAssociatedObject(touch, key, fingerView, OBJC_ASSOCIATION_ASSIGN);
        
        [self.touchesView addSubview:fingerView];
    }
    
    fingerView.center = point;
}

- (void)removeFingerViewForTouch:(UITouch *)touch
{
    void *key = (__bridge void *)kFLEXFingerViewAssociatedKey;
    
    FLEXTouchFingerView* fingerView = objc_getAssociatedObject (touch, key);
    
    if (fingerView)
    {
        objc_setAssociatedObject(touch, key, nil, OBJC_ASSOCIATION_ASSIGN);
        
        [fingerView removeFromSuperview];
    }
}

@end
