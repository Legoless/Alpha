//
//  ALPHAToolbarItem.m
//  Alpha
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAToolbarItem.h"
#import "ALPHAUtility.h"

#import "ALPHAManager.h"

@interface ALPHAToolbarItem ()

@property (nonatomic, copy) NSAttributedString *attributedTitle;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ALPHAToolbarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [ALPHAManager defaultManager].theme.toolbarBackgroundColor;
        [self setTitleColor:[ALPHAManager defaultManager].theme.toolbarTintColor forState:UIControlStateNormal];
        [self setTitleColor:[ALPHAManager defaultManager].theme.toolbarTintDisabledColor forState:UIControlStateDisabled];
    }
    
    return self;
}

+ (instancetype)toolbarItemWithTitle:(NSString *)title image:(UIImage *)image
{
    ALPHATheme* theme = [ALPHAManager defaultManager].theme;
    
    ALPHAToolbarItem *toolbarItem = [self buttonWithType:UIButtonTypeCustom];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:@{ NSFontAttributeName : theme.toolbarTitleFont, NSForegroundColorAttributeName : theme.toolbarTintColor }];
    toolbarItem.attributedTitle = attributedTitle;
    [toolbarItem setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [toolbarItem setImage:image forState:UIControlStateNormal];
    toolbarItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return toolbarItem;
}


#pragma mark - State Changes

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateBackgroundColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateBackgroundColor];
}

- (void)updateBackgroundColor
{
    if (self.highlighted)
    {
        self.backgroundColor = [ALPHAManager defaultManager].theme.toolbarHighlightedColor;
    }
    else if (self.selected)
    {
        self.backgroundColor = [ALPHAManager defaultManager].theme.toolbarSelectedColor;
    }
    else
    {
        self.backgroundColor = [ALPHAManager defaultManager].theme.toolbarBackgroundColor;
    }
}

#pragma mark - UIButton Layout Overrides

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    // Bottom aligned and centered.
    CGRect titleRect = CGRectZero;
    CGSize titleSize = [self.attributedTitle boundingRectWithSize:contentRect.size options:0 context:nil].size;
    titleSize = CGSizeMake(ceil(titleSize.width), ceil(titleSize.height));
    titleRect.size = titleSize;
    titleRect.origin.y = contentRect.origin.y + CGRectGetMaxY(contentRect) - titleSize.height;
    titleRect.origin.x = contentRect.origin.x + ALPHAFloor((contentRect.size.width - titleSize.width) / 2.0);
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    CGFloat availableHeight = contentRect.size.height - titleRect.size.height - ([ALPHAManager defaultManager].theme.toolbarTopMargin * 2.0);
    CGFloat originY = [ALPHAManager defaultManager].theme.toolbarTopMargin;
    CGRect imageRect = CGRectMake(0.0, originY, contentRect.size.width, availableHeight);
    return imageRect;
}

@end
