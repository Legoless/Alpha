//
//  ALPHATheme.m
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHANavigationController.h"

#import "UIImage+ALPHACreation.h"

#import "UIApplication+ALPHAPrivate.h"

#import "ALPHATheme.h"
#import "FLEXUtility.h"
#import "ALPHAManager+Private.h"

@implementation ALPHATheme

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.fontFamily = @"Menlo";
        
        self.topMargin = 2.0;
        
        self.tintColor = [UIColor blackColor];
        
        self.disabledTitleColor = [UIColor lightGrayColor];
        self.highlightedBackgroundColor = [UIColor grayColor];
        self.selectedBackgroundColor = [UIColor darkGrayColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

+ (instancetype)theme
{
    return [[[self class] alloc] init];
}

- (void)applyInWindow:(UIWindow *)window
{
    window.tintColor = self.tintColor;
    
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:self.fontFamily size:17.0], NSForegroundColorAttributeName : self.tintColor }];
    
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setBackgroundImage:[UIImage alpha_imageWithColor:self.highlightedBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTranslucent:NO];
    [[UINavigationBar appearanceWhenContainedIn:[ALPHANavigationController class], nil] setShadowImage:[UIImage alpha_imageWithColor:self.selectedBackgroundColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:self.fontFamily size:14.0] } forState:UIControlStateNormal];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:self.fontFamily size:12.0], NSForegroundColorAttributeName : self.tintColor }];
    
    [[UISegmentedControl appearanceWhenContainedIn:[ALPHANavigationController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:self.fontFamily size:12.0], NSForegroundColorAttributeName : self.tintColor } forState:UIControlStateNormal];
    //id statusBar = [[UIApplication sharedApplication] statusBar];
    
    //[statusBar performSelector:NSSelectorFromString(@"setForegroundColor:") withObject:self.tintColor];
}

- (UIFont *)italicThemeFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:@"Italic" ofSize:size];
}

- (UIFont *)boldThemeFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:@"Bold" ofSize:size];
}

- (UIFont *)boldItalicThemeFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:@"BoldItalic" ofSize:size];
}

- (UIFont *)themeFontOfSize:(CGFloat)size
{
    return [self fontWithStyle:nil ofSize:size];
}

- (UIFont *)themeFontWithFont:(UIFont *)font
{
    return [self themeFontOfSize:font.pointSize];
}

- (UIFont *)italicThemeFontWithFont:(UIFont *)font
{
    return [self italicThemeFontOfSize:font.pointSize];
}

- (UIFont *)boldThemeFontWithFont:(UIFont *)font
{
    return [self boldThemeFontOfSize:font.pointSize];
}

- (UIFont *)boldItalicThemeFontWithFont:(UIFont *)font
{
    return [self boldItalicThemeFontOfSize:font.pointSize];
}

#pragma mark - Private methods

- (UIFont *)fontWithStyle:(NSString *)fontStyle ofSize:(CGFloat)size
{
    NSString* fontFamily = self.fontFamily;
    
    if (fontStyle)
    {
        fontFamily = [NSString stringWithFormat:@"%@-%@", self.fontFamily, fontStyle];
    }
    
    return [UIFont fontWithName:fontFamily size:size - 2.0];
}

@end
