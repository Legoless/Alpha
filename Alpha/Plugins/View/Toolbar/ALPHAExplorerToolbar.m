//
//  ALPHAExplorerToolbar.m
//  Alpha
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAExplorerToolbar.h"
#import "ALPHAToolbarItem.h"
#import "ALPHAUtility.h"
#import "ALPHAManager.h"

#import "ALPHACoreAssets.h"
#import "ALPHAViewIcon.h"
#import "ALPHASelectIcon.h"
#import "ALPHAMoveIcon.H"

@interface ALPHAExplorerToolbar ()

@property (nonatomic, strong, readwrite) ALPHAToolbarItem *selectItem;
@property (nonatomic, strong, readwrite) ALPHAToolbarItem *moveItem;
@property (nonatomic, strong, readwrite) ALPHAToolbarItem *globalsItem;
@property (nonatomic, strong, readwrite) ALPHAToolbarItem *closeItem;
@property (nonatomic, strong, readwrite) ALPHAToolbarItem *hierarchyItem;
@property (nonatomic, strong, readwrite) UIView *dragHandle;

@property (nonatomic, strong) UIImageView *dragHandleImageView;

@property (nonatomic, strong) NSArray *toolbarItems;

@property (nonatomic, strong) UIView *selectedViewDescriptionContainer;
@property (nonatomic, strong) UIView *selectedViewColorIndicator;
@property (nonatomic, strong) UILabel *selectedViewDescriptionLabel;

@end

@implementation ALPHAExplorerToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [ALPHAManager defaultManager].theme.mainColor;
        
        NSMutableArray *toolbarItems = [NSMutableArray array];
        
        self.dragHandle = [[UIView alloc] init];
        self.dragHandle.backgroundColor = [ALPHAManager defaultManager].theme.toolbarBackgroundColor;
        [self addSubview:self.dragHandle];
        
        UIImage *dragHandle = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconDragHandleIdentifier];
        self.dragHandleImageView = [[UIImageView alloc] initWithImage:dragHandle];
        self.dragHandleImageView.tintColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        
        [self.dragHandle addSubview:self.dragHandleImageView];
        
        UIImage *globalsIcon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconInfoIdentifier];
        self.globalsItem = [ALPHAToolbarItem toolbarItemWithTitle:@"info" image:globalsIcon];
        self.globalsItem.tintColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        [self addSubview:self.globalsItem];
        [toolbarItems addObject:self.globalsItem];
        
        UIImage *listIcon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconViewIdentifier];
        self.hierarchyItem = [ALPHAToolbarItem toolbarItemWithTitle:@"views" image:listIcon];
        self.hierarchyItem.tintColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        [self addSubview:self.hierarchyItem];
        [toolbarItems addObject:self.hierarchyItem];
        
        UIImage *selectIcon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconSelectIdentifier];
        self.selectItem = [ALPHAToolbarItem toolbarItemWithTitle:@"select" image:selectIcon];
        self.selectItem.tintColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        [self addSubview:self.selectItem];
        [toolbarItems addObject:self.selectItem];
        
        UIImage *moveIcon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconMoveIdentifier];
        self.moveItem = [ALPHAToolbarItem toolbarItemWithTitle:@"move" image:moveIcon];
        self.moveItem.tintColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        [self addSubview:self.moveItem];
        [toolbarItems addObject:self.moveItem];
        
        UIImage *closeIcon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconCloseIdentifier];
        self.closeItem = [ALPHAToolbarItem toolbarItemWithTitle:@"close" image:closeIcon];
        self.closeItem.tintColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        [self addSubview:self.closeItem];
        [toolbarItems addObject:self.closeItem];
        
        self.toolbarItems = toolbarItems;
        self.backgroundColor = [UIColor clearColor];
        
        self.selectedViewDescriptionContainer = [[UIView alloc] init];
        self.selectedViewDescriptionContainer.backgroundColor = [ALPHAManager defaultManager].theme.toolbarDetailBackgroundColor;
        self.selectedViewDescriptionContainer.hidden = YES;
        [self addSubview:self.selectedViewDescriptionContainer];
        
        self.selectedViewColorIndicator = [[UIView alloc] init];
        self.selectedViewColorIndicator.backgroundColor = [UIColor redColor];
        [self.selectedViewDescriptionContainer addSubview:self.selectedViewColorIndicator];
        
        self.selectedViewDescriptionLabel = [[UILabel alloc] init];
        self.selectedViewDescriptionLabel.backgroundColor = [UIColor clearColor];
        self.selectedViewDescriptionLabel.font = [[self class] descriptionLabelFont];
        self.selectedViewDescriptionLabel.textColor = [ALPHAManager defaultManager].theme.toolbarDetailTintColor;
        [self.selectedViewDescriptionContainer addSubview:self.selectedViewDescriptionLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Drag Handle
    const CGFloat kToolbarItemHeight = [[self class] toolbarItemHeight];
    self.dragHandle.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [[self class] dragHandleWidth], kToolbarItemHeight);
    CGRect dragHandleImageFrame = self.dragHandleImageView.frame;
    dragHandleImageFrame.origin.x = ALPHAFloor((self.dragHandle.frame.size.width - dragHandleImageFrame.size.width) / 2.0);
    dragHandleImageFrame.origin.y = ALPHAFloor((self.dragHandle.frame.size.height - dragHandleImageFrame.size.height) / 2.0);
    self.dragHandleImageView.frame = dragHandleImageFrame;
    
    
    // Toolbar Items
    CGFloat originX = CGRectGetMaxX(self.dragHandle.frame);
    CGFloat originY = self.bounds.origin.y;
    CGFloat height = kToolbarItemHeight;
    CGFloat width = ALPHAFloor((CGRectGetMaxX(self.bounds) - originX) / [self.toolbarItems count]);
    for (UIView *toolbarItem in self.toolbarItems) {
        toolbarItem.frame = CGRectMake(originX, originY, width, height);
        originX = CGRectGetMaxX(toolbarItem.frame);
    }
    
    // Make sure the last toolbar item goes to the edge to account for any accumulated rounding effects.
    UIView *lastToolbarItem = [self.toolbarItems lastObject];
    CGRect lastToolbarItemFrame = lastToolbarItem.frame;
    lastToolbarItemFrame.size.width = CGRectGetMaxX(self.bounds) - lastToolbarItemFrame.origin.x;
    lastToolbarItem.frame = lastToolbarItemFrame;
    
    const CGFloat kSelectedViewColorDiameter = [[self class] selectedViewColorIndicatorDiameter];
    const CGFloat kDescriptionLabelHeight = [[self class] descriptionLabelHeight];
    const CGFloat kHorizontalPadding = [[self class] horizontalPadding];
    const CGFloat kDescriptionVerticalPadding = [[self class] descriptionVerticalPadding];
    const CGFloat kDescriptionContainerHeight = [[self class] descriptionContainerHeight];
    
    CGRect descriptionContainerFrame = CGRectZero;
    descriptionContainerFrame.size.height = kDescriptionContainerHeight;
    descriptionContainerFrame.origin.y = CGRectGetMaxY(self.bounds) - kDescriptionContainerHeight;
    descriptionContainerFrame.size.width = self.bounds.size.width;
    self.selectedViewDescriptionContainer.frame = descriptionContainerFrame;
    
    // Selected View Color
    CGRect selectedViewColorFrame = CGRectZero;
    selectedViewColorFrame.size.width = kSelectedViewColorDiameter;
    selectedViewColorFrame.size.height = kSelectedViewColorDiameter;
    selectedViewColorFrame.origin.x = kHorizontalPadding;
    selectedViewColorFrame.origin.y = ALPHAFloor((kDescriptionContainerHeight - kSelectedViewColorDiameter) / 2.0);
    self.selectedViewColorIndicator.frame = selectedViewColorFrame;
    self.selectedViewColorIndicator.layer.cornerRadius = ceil(selectedViewColorFrame.size.height / 2.0);
    
    // Selected View Description
    CGRect descriptionLabelFrame = CGRectZero;
    CGFloat descriptionOriginX = CGRectGetMaxX(selectedViewColorFrame) + kHorizontalPadding;
    descriptionLabelFrame.size.height = kDescriptionLabelHeight;
    descriptionLabelFrame.origin.x = descriptionOriginX;
    descriptionLabelFrame.origin.y = kDescriptionVerticalPadding;
    descriptionLabelFrame.size.width = CGRectGetMaxX(self.selectedViewDescriptionContainer.bounds) - kHorizontalPadding - descriptionOriginX;
    self.selectedViewDescriptionLabel.frame = descriptionLabelFrame;
}


#pragma mark - Setter Overrides

- (void)setSelectedViewOverlayColor:(UIColor *)selectedViewOverlayColor
{
    if (![_selectedViewOverlayColor isEqual:selectedViewOverlayColor]) {
        _selectedViewOverlayColor = selectedViewOverlayColor;
        self.selectedViewColorIndicator.backgroundColor = selectedViewOverlayColor;
    }
}

- (void)setSelectedViewDescription:(NSString *)selectedViewDescription
{
    if (![_selectedViewDescription isEqual:selectedViewDescription]) {
        _selectedViewDescription = selectedViewDescription;
        self.selectedViewDescriptionLabel.text = selectedViewDescription;
        BOOL showDescription = [selectedViewDescription length] > 0;
        self.selectedViewDescriptionContainer.hidden = !showDescription;
    }
}


#pragma mark - Sizing Convenience Methods

+ (UIFont *)descriptionLabelFont
{
    return [ALPHAManager defaultManager].theme.toolbarDetailFont;
}

+ (CGFloat)toolbarItemHeight
{
    return 44.0;
}

+ (CGFloat)dragHandleWidth
{
    return 20.0;
}

+ (CGFloat)descriptionLabelHeight
{
    return ceil([[self descriptionLabelFont] lineHeight]);
}

+ (CGFloat)descriptionVerticalPadding
{
    return 2.0;
}

+ (CGFloat)descriptionContainerHeight
{
    return [self descriptionVerticalPadding] * 2.0 + [self descriptionLabelHeight];
}

+ (CGFloat)selectedViewColorIndicatorDiameter
{
    return ceil([self descriptionLabelHeight] / 2.0);
}

+ (CGFloat)horizontalPadding
{
    return 11.0;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat height = 0.0;
    height += [[self class] toolbarItemHeight];
    height += [[self class] descriptionContainerHeight];
    return CGSizeMake(size.width, height);
}

@end
