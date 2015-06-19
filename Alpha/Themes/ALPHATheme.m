//
//  ALPHATheme.m
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHANavigationController.h"

#import "UIImage+Creation.h"

#import "UIApplication+ALPHAPrivate.h"

#import "ALPHATheme.h"
#import "ALPHAUtility.h"

@implementation ALPHATheme

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        //
        // Defaults
        //
        
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.keyboardAppearance = UIKeyboardAppearanceDark;
        
        //
        // Toolbar
        //
        
        self.toolbarTopMargin = 4.0;
        
        self.tableHeaderHeight = UITableViewAutomaticDimension;
        self.tableHeaderMargin = UIEdgeInsetsMake(8.0, 17.0, 0.0, 0.0);
        
        self.tableFooterHeight = UITableViewAutomaticDimension;
        self.tableFooterMargin = UIEdgeInsetsZero;
        
        self.tableHeaderGroupedHeight = UITableViewAutomaticDimension;
        self.tableHeaderGroupedMargin = UIEdgeInsetsMake(8.0, 17.0, 0.0, 0.0);
        
        self.tableFooterGroupedHeight = UITableViewAutomaticDimension;
        self.tableFooterGroupedMargin = UIEdgeInsetsZero;
        
        self.fieldTitleBottomMargin = 4.0;
        
        self.fieldInputBorderWidth = 1.0;
        self.imageViewBorderWidth = 1.0;
    }
    
    return self;
}

+ (instancetype)theme
{
    return [[[self class] alloc] init];
}

#pragma mark - Public Methods

- (void)applyInWindow:(UIWindow *)window
{
    window.tintColor = self.mainColor;
    
    //
    // Applying theme as much as possible via UIAppearance
    //
    
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : self.headerTitleFont, NSForegroundColorAttributeName : self.headerTitleColor }];
    
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setBackgroundImage:[UIImage alpha_imageWithColor:self.headerBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTranslucent:NO];
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setShadowImage:[UIImage alpha_imageWithColor:self.headerShadowColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : self.headerButtonFont, NSForegroundColorAttributeName : self.headerButtonColor } forState:UIControlStateNormal];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{ NSFontAttributeName : self.searchBarFont, NSForegroundColorAttributeName : self.searchTintColor }];
    
    [[UISegmentedControl appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : self.searchBarFont, NSForegroundColorAttributeName : self.searchTintColor } forState:UIControlStateNormal];
    //id statusBar = [[UIApplication sharedApplication] statusBar];
    
    //[statusBar performSelector:NSSelectorFromString(@"setForegroundColor:") withObject:self.mainColor];
}

- (CGRect)rect:(CGRect)rect withMargin:(UIEdgeInsets)margin
{
    //CGRect newRect = CGRectZero;
    rect.origin.x += margin.left;
    rect.origin.y += margin.top;
    rect.size.width -= margin.left + margin.right;
    rect.size.height -= margin.top + margin.bottom;
    
    return rect;
}

#pragma mark - Private Methods

/*!
 *  Creates all UIFonts with specified family
 *
 *  @param fontFamily
 */
- (void)setFontsWithFamily:(NSString *)fontFamily
{
    [self setHeaderFontsWithFamily:fontFamily];
    [self setContentFontsWithFamily:fontFamily];
}

- (void)setHeaderFontsWithFamily:(NSString *)fontFamily
{
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:17.0];
    self.headerButtonFont = [UIFont fontWithName:fontFamily size:14.0];
    
    self.notificationFont = [UIFont fontWithName:fontFamily size:8.0];
    self.toolbarTitleFont = [UIFont fontWithName:fontFamily size:10.0];
    
    self.toolbarDetailFont = [UIFont fontWithName:fontFamily size:8.0];
    
    self.searchBarFont = [UIFont fontWithName:fontFamily size:12.0];
    self.fieldInputFont = [UIFont fontWithName:fontFamily size:12.0];
    
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:17.0];
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:17.0];
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:17.0];
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:17.0];
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:17.0];
}

- (void)setContentFontsWithFamily:(NSString *)fontFamily
{
    self.cellTitleFont = [UIFont fontWithName:fontFamily size:12.0];
    self.cellSubtitleFont = [UIFont fontWithName:fontFamily size:10.0];
    self.cellDetailFont = [UIFont fontWithName:fontFamily size:12.0];
    
    self.tableHeaderFont = [UIFont fontWithName:fontFamily size:11.0];
    self.tableFooterFont = [UIFont fontWithName:fontFamily size:11.0];
    
    self.tableHeaderGroupedFont = [UIFont fontWithName:fontFamily size:11.0];
    self.tableFooterGroupedFont = [UIFont fontWithName:fontFamily size:11.0];
    
    self.fieldTitleFont = [UIFont fontWithName:fontFamily size:12.0];
    
    self.fieldToolbarFont = [UIFont fontWithName:fontFamily size:10.0];
    
    self.fieldColorFont = [UIFont fontWithName:fontFamily size:12.0];
    self.fieldColorComponentFont = [UIFont fontWithName:fontFamily size:12.0];
}

@end
