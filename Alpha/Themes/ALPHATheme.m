//
//  ALPHATheme.m
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import UIKit;

#import "UIImage+Creation.h"

#import "ALPHATheme.h"

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
        
        self.tableHeaderHeight = 30.0;
        self.tableHeaderMargin = UIEdgeInsetsMake(0.0, 17.0, 0.0, 0.0);
        
        self.tableFooterHeight = 30.0;
        self.tableFooterMargin = UIEdgeInsetsZero;
        
        self.tableHeaderGroupedHeight = 40.0;
        self.tableHeaderGroupedMargin = UIEdgeInsetsMake(8.0, 17.0, 0.0, 0.0);
        
        self.tableFooterGroupedHeight = 40.0;
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

    Class navigationControllerClass = NSClassFromString(@"ALPHANavigationController");

    //
    // iOS 9 deprecates appearanceWhenContainedIn:, but we still must fallback to it for iOS 8.
    //
    if ([navigationControllerClass respondsToSelector:@selector(appearanceWhenContainedInInstancesOfClasses:)]) {
        if (navigationControllerClass)
        {
            [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass ]] setTitleTextAttributes:@{ NSFontAttributeName : self.headerTitleFont, NSForegroundColorAttributeName : self.headerTitleColor }];
            
            [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass ]] setBackgroundImage:[UIImage alpha_imageWithColor:self.headerBackgroundColor] forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass]] setTranslucent:NO];
            [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass ]] setTintColor:self.headerButtonColor];
            [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass ]] setShadowImage:[UIImage alpha_imageWithColor:self.headerShadowColor]];
            
            [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass ]] setTitleTextAttributes:@{ NSFontAttributeName : self.headerButtonFont, NSForegroundColorAttributeName : self.headerButtonColor } forState:UIControlStateNormal];
            
            [[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[ navigationControllerClass ]] setTitleTextAttributes:@{ NSFontAttributeName : self.searchBarFont, NSForegroundColorAttributeName : self.searchTintColor } forState:UIControlStateNormal];
        }
        
        [[UITextField appearanceWhenContainedInInstancesOfClasses:@[ [UISearchBar class] ]] setDefaultTextAttributes:@{ NSFontAttributeName : self.searchBarFont, NSForegroundColorAttributeName : self.searchTintColor }];
    }
    else {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        //
        // Here we are in iOS 8, so we must call the deprecated methods. Disable warnings.
        //
        
        if (navigationControllerClass)
        {
            [[UINavigationBar appearanceWhenContainedIn:navigationControllerClass, nil] setTitleTextAttributes:@{ NSFontAttributeName : self.headerTitleFont, NSForegroundColorAttributeName : self.headerTitleColor }];
            
            [[UINavigationBar appearanceWhenContainedIn:navigationControllerClass, nil] setBackgroundImage:[UIImage alpha_imageWithColor:self.headerBackgroundColor] forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearanceWhenContainedIn:navigationControllerClass, nil] setTranslucent:NO];
            [[UINavigationBar appearanceWhenContainedIn:navigationControllerClass, nil] setTintColor:self.headerButtonColor];
            [[UINavigationBar appearanceWhenContainedIn:navigationControllerClass, nil] setShadowImage:[UIImage alpha_imageWithColor:self.headerShadowColor]];
            
            [[UIBarButtonItem appearanceWhenContainedIn:navigationControllerClass, nil] setTitleTextAttributes:@{ NSFontAttributeName : self.headerButtonFont, NSForegroundColorAttributeName : self.headerButtonColor } forState:UIControlStateNormal];
            
            [[UISegmentedControl appearanceWhenContainedIn:navigationControllerClass, nil] setTitleTextAttributes:@{ NSFontAttributeName : self.searchBarFont, NSForegroundColorAttributeName : self.searchTintColor } forState:UIControlStateNormal];
        }
        
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{ NSFontAttributeName : self.searchBarFont, NSForegroundColorAttributeName : self.searchTintColor }];
        
        #pragma clang diagnostic pop
    }
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
 *  @param fontFamily   font family
 *  @param size         font size
 */
- (void)setFontsWithFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)size
{
    [self setHeaderFontsWithFamily:fontFamily defaultPointSize:size];
    [self setContentFontsWithFamily:fontFamily defaultPointSize:size];
}

- (void)setHeaderFontsWithFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)size
{
    self.headerTitleFont = [UIFont fontWithName:fontFamily size:size + 5.0];
    self.headerButtonFont = [UIFont fontWithName:fontFamily size:size + 2.0];
    
    self.notificationFont = [UIFont fontWithName:fontFamily size:size - 4.0];
    self.toolbarTitleFont = [UIFont fontWithName:fontFamily size:size - 2.0];
    
    self.searchBarFont = [UIFont fontWithName:fontFamily size:size];
    self.fieldInputFont = [UIFont fontWithName:fontFamily size:size];
}

- (void)setContentFontsWithFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)size
{
    self.toolbarDetailFont = [UIFont fontWithName:fontFamily size:size - 4.0];
    
    self.cellTitleFont = [UIFont fontWithName:fontFamily size:size];
    self.cellSubtitleFont = [UIFont fontWithName:fontFamily size:size - 2.0];
    self.cellDetailFont = [UIFont fontWithName:fontFamily size:size];
    
    self.tableHeaderFont = [UIFont fontWithName:fontFamily size:size - 1.0];
    self.tableFooterFont = [UIFont fontWithName:fontFamily size:size - 1.0];
    
    self.tableHeaderGroupedFont = [UIFont fontWithName:fontFamily size:size - 1.0];
    self.tableFooterGroupedFont = [UIFont fontWithName:fontFamily size:size - 1.0];
    
    self.fieldTitleFont = [UIFont fontWithName:fontFamily size:size];
    
    self.fieldToolbarFont = [UIFont fontWithName:fontFamily size:size - 2.0];
    
    self.fieldColorFont = [UIFont fontWithName:fontFamily size:size];
    self.fieldColorComponentFont = [UIFont fontWithName:fontFamily size:size];
}

@end
