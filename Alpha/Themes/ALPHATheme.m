//
//  ALPHATheme.m
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHANavigationController.h"

#import "UIImage+Creation.h"

#import "UIApplication+ALPHAPrivate.h"

#import "ALPHATheme.h"
#import "ALPHAUtility.h"

@implementation ALPHATheme

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        /*
        self.fontFamily = @"Menlo";
        
        self.topMargin = 4.0;
        
        self.mainColor = [UIColor blackColor];
        
        self.disabledTitleColor = [UIColor lightGrayColor];
        self.highlightedBackgroundColor = [UIColor grayColor];
        self.selectedBackgroundColor = [UIColor darkGrayColor];
        self.backgroundColor = [UIColor whiteColor];*/
    }
    
    return self;
}

+ (instancetype)theme
{
    return [[[self class] alloc] init];
}

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


@end
