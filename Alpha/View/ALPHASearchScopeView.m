//
//  ALPHASearchScopeView.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASearchScopeView.h"

@implementation ALPHASearchScopeView

#pragma mark - Getters and Setters

- (NSInteger)selectedScopeButtonIndex
{
    return self.segmentedControl.selectedSegmentIndex;
}

- (void)setSelectedScopeButtonIndex:(NSInteger)selectedScopeButtonIndex
{
    self.segmentedControl.selectedSegmentIndex = selectedScopeButtonIndex;
}

- (void)setShowsScopeBar:(BOOL)showsScopeBar
{
    _showsScopeBar = showsScopeBar;
    
    [self layoutIfNeeded];
}

- (void)setShowsSearchBar:(BOOL)showsSearchBar
{
    _showsSearchBar = showsSearchBar;
    
    [self layoutIfNeeded];
}

- (void)setScopeButtonTitles:(NSArray *)scopeButtonTitles
{
    _scopeButtonTitles = scopeButtonTitles;
    
    [self.segmentedControl removeAllSegments];
    
    NSUInteger counter = 0;
    
    for (NSString* title in scopeButtonTitles)
    {
        [self.segmentedControl insertSegmentWithTitle:title atIndex:counter animated:NO];
        
        counter++;
    }
    
    [self.segmentedControl sizeToFit];
    
    self.segmentedControl.selectedSegmentIndex = 0;
}

- (void)setDelegate:(id<UISearchBarDelegate>)delegate
{
    _delegate = delegate;
    
    self.searchBar.delegate = delegate;
}

- (NSString *)placeholder
{
    return self.searchBar.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.searchBar.placeholder = placeholder;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
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
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.barStyle = UISearchBarStyleMinimal;
    self.searchBar.translucent = NO;
    self.searchBar.backgroundImage = [UIImage new];
    self.searchBar.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.searchBar];
    
    self.segmentedControl = [[UISegmentedControl alloc] init];
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlItemChanged) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:self.segmentedControl];
    
    [self layoutIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    self.searchBar.barTintColor = backgroundColor;
}

#pragma mark - UIView

- (void)sizeToFit
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //
    // Will place both correctly regardless of current position
    //
    
    CGFloat width = self.superview.bounds.size.width;
    CGFloat currentOffset = 0.0;
    
    if (self.showsSearchBar)
    {
        CGRect frame = CGRectMake(0.0, currentOffset, width, 44.0);
        self.searchBar.frame = frame;
        self.searchBar.hidden = NO;
        
        currentOffset += 44.0;
    }
    else
    {
        self.searchBar.hidden = YES;
    }
    
    CGFloat offset = 8.0;
    
    if (self.showsScopeBar)
    {
        CGRect frame = CGRectMake(offset, currentOffset + offset, width - (offset * 2.0), 44.0 - (offset * 2.0));
        
        self.segmentedControl.frame = frame;
        self.segmentedControl.hidden = NO;
        self.segmentedControl.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        currentOffset += 44.0;
    }
    else
    {
        self.segmentedControl.hidden = YES;
    }
    
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = currentOffset;
    
    self.frame = frame;
}

#pragma mark - Private methods

- (void)segmentedControlItemChanged
{
    if (!self.scopeButtonTitles.count || !self.showsScopeBar)
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)])
    {
        [self.delegate searchBar:self.searchBar selectedScopeButtonIndexDidChange:self.segmentedControl.selectedSegmentIndex];
    }
}

@end
