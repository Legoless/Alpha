//
//  ALPHAMenuCenterView.m
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMenuCenterView.h"
#import "ALPHAManager.h"

@interface ALPHAMenuCenterView ()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation ALPHAMenuCenterView

#pragma mark - Getters and setters

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

#pragma mark - UIView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    //ALPHAManager* manager = [ALPHAManager defaultManager];
    
    self.mainBackgroundColor = [UIColor blackColor];
    self.tintColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:[self rectWithPaddingPercent:0.45]];
    self.imageView.userInteractionEnabled = NO;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:self.imageView];
}

- (CGRect)rectWithPaddingPercent:(CGFloat)paddingPercent
{
    CGRect rect = self.bounds;
    CGRect originalRect = self.bounds;
    
    CGFloat size = 1.0 - paddingPercent;
    
    rect.size.width *= size;
    rect.size.height *= size;
    
    CGFloat paddingX = (originalRect.size.width - rect.size.width) / 2.0;
    CGFloat paddingY = (originalRect.size.height - rect.size.height) / 2.0;
    
    rect.origin.x = paddingX;
    rect.origin.y = paddingY;
    
    return rect;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = self.mainBackgroundColor;
    UIColor* color2 = self.tintColor;
    
    CGFloat innerModifier1 = 0.87;
    CGFloat innerModifier2 = 0.78;
    
    //// Group
    {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
        [color setFill];
        [ovalPath fill];
        
        
        CGFloat padding = (rect.size.width - (rect.size.width * innerModifier1)) / 2.0;
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(padding, padding, rect.size.width * innerModifier1, rect.size.height * innerModifier1)];
        [color2 setFill];
        [oval2Path fill];
        
        padding = (rect.size.width - (rect.size.width * innerModifier2)) / 2.0;
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(padding, padding, rect.size.width * innerModifier2, rect.size.height * innerModifier2)];
        [color setFill];
        [oval3Path fill];
    }
}

@end
