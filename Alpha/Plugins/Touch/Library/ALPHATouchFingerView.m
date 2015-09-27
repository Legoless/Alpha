//
//  ALPHATouchFingerView.m
//  Alpha
//
//  Created by Dal Rupnik on 18/09/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

#import "ALPHATouchFingerView.h"

CGFloat const ALPHADefaultMaxFingerRadius = 22.0;
CGFloat const ALPHADefaultForceTouchScale = 0.75;

@interface ALPHATouchFingerView ()

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) CATransform3D touchEndTransform;
@property (nonatomic, assign) CGFloat touchEndAnimationDuration;

@property (nonatomic, strong) UITouch *touch;

@property (nonatomic, assign) CGPoint lastScale;

@end

@implementation ALPHATouchFingerView

#pragma mark - Getters and Setters

- (void)setBackgroundColor:(UIColor *)color
{
    [super setBackgroundColor:color];
    
    self.layer.borderColor = [color colorWithAlphaComponent:0.6f].CGColor;
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
    [UIView animateWithDuration:self.touchEndAnimationDuration animations:^
    {
        self.alpha = 0.0f;
        self.layer.transform = self.touchEndTransform;
    }
    completion:^(BOOL completed)
    {
        [super removeFromSuperview];
    }];
}

#pragma mark - ALPHATouchposeFingerView

- (instancetype)initWithPoint:(CGPoint)point
{
    
    if ((self = [super initWithFrame:CGRectMake(point.x - ALPHADefaultMaxFingerRadius, point.y - ALPHADefaultMaxFingerRadius, 2 * ALPHADefaultMaxFingerRadius, 2 * ALPHADefaultMaxFingerRadius)]))
    {
        self.opaque = NO;
        
        self.color = [UIColor colorWithRed:0.251f green:0.424f blue:0.502f alpha:1.0f];
        
        self.backgroundColor = [self.color colorWithAlphaComponent:0.4];

        self.layer.cornerRadius = ALPHADefaultMaxFingerRadius;
        self.layer.borderWidth = 2.0f;
        
        self.touchEndAnimationDuration = 0.5f;
        
        self.lastScale = CGPointMake(1.0, 1.0);
        
        self.touchEndTransform = CATransform3DMakeScale(1.5, 1.5, 1);
    }
    
    return self;
}

- (void)updateWithTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.superview];
    
    self.center = point;
    
    self.lastScale = CGPointMake(MAX(1, touch.force * ALPHADefaultForceTouchScale), MAX(1, touch.force * ALPHADefaultForceTouchScale));
    
    self.transform = CGAffineTransformMakeScale(self.lastScale.x, self.lastScale.y);
    
    CGFloat force = touch.maximumPossibleForce - touch.force;
    
    UIColor *forceColor = [UIColor alpha_interpolatedColorFromStartColor:[UIColor redColor] endColor:self.color fraction:force];
    
    self.backgroundColor = [forceColor colorWithAlphaComponent:0.4];
}

@end
