//
//  FLEXToolbarItem.m
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXToolbarItem.h"
#import "ALPHAUtility.h"

#import "ALPHAManager.h"

@interface FLEXToolbarItem ()

@property (nonatomic, copy) NSAttributedString *attributedTitle;
@property (nonatomic, strong) UIImage *image;

@end

@implementation FLEXToolbarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ALPHAManager sharedManager].theme.backgroundColor;
        [self setTitleColor:[ALPHAManager sharedManager].theme.tintColor forState:UIControlStateNormal];
        [self setTitleColor:[ALPHAManager sharedManager].theme.disabledTitleColor forState:UIControlStateDisabled];
    }
    return self;
}

+ (instancetype)toolbarItemWithTitle:(NSString *)title image:(UIImage *)image
{
    ALPHATheme* theme = [ALPHAManager sharedManager].theme;
    
    FLEXToolbarItem *toolbarItem = [self buttonWithType:UIButtonTypeCustom];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:@{ NSFontAttributeName : [theme themeFontOfSize:10.0], NSForegroundColorAttributeName : theme.tintColor }];
    toolbarItem.attributedTitle = attributedTitle;
    [toolbarItem setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [toolbarItem setImage:image forState:UIControlStateNormal];
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
    if (self.highlighted) {
        self.backgroundColor = [ALPHAManager sharedManager].theme.highlightedBackgroundColor;
    } else if (self.selected) {
        self.backgroundColor = [ALPHAManager sharedManager].theme.selectedBackgroundColor;
    } else {
        self.backgroundColor = [ALPHAManager sharedManager].theme.backgroundColor;
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
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    CGFloat availableHeight = contentRect.size.height - titleRect.size.height - [ALPHAManager sharedManager].theme.topMargin;
    CGFloat originY = [ALPHAManager sharedManager].theme.topMargin + ALPHAFloor((availableHeight - imageSize.height) / 2.0);
    CGFloat originX = ALPHAFloor((contentRect.size.width - imageSize.width) / 2.0);
    CGRect imageRect = CGRectMake(originX, originY, imageSize.width, imageSize.height);
    return imageRect;
}

@end
