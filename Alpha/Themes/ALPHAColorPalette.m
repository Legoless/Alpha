//
//  ALPHAColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHAColorPalette.h"
#import "UIColor+Tools.h"

@implementation ALPHAColorPalette

- (ALPHATheme *)paletteTheme
{
    ALPHATheme *theme = [ALPHATheme theme];
    
    [theme setHeaderFontsWithFamily:self.headerFontFamily defaultPointSize:self.headerFontSize];
    [theme setContentFontsWithFamily:self.contentFontFamily defaultPointSize:self.contentFontSize];
    
    //
    // Light modifier so we get accents lighter or darker based on theme
    //
    CGFloat isLight = ([self.backgroundColor alpha_brightness] > 0.5) ? 1.0 : -1.0;
    
    theme.statusBarStyle = isLight > 0 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    
    //
    // Set colors
    //
    theme.backgroundColor = self.backgroundColor;
    theme.mainColor = self.accentColor;
    theme.headerTitleColor = self.accentColor;
    theme.headerButtonColor = self.accentColor;
    
    theme.headerBackgroundColor = self.mainColor;
    theme.headerShadowColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.05 * isLight];
    theme.notificationBackgroundColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.2 * isLight];
    theme.notificationTintColor = self.accentColor;
    
    theme.menuBackgroundColor = self.mainColor;
    theme.menuTintColor = self.accentColor;
    theme.menuButtonBackgroundColor = [theme.menuButtonBackgroundColor colorWithAlphaComponent:0.8];
    theme.menuButtonSelectedBackgroundColor = [self.mainColor alpha_colorWithBrightnessModifier:0.1];
    
    theme.toolbarBackgroundColor = self.mainColor;
    theme.toolbarSelectedColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.15 * isLight];
    theme.toolbarHighlightedColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.2 * isLight];
    
    theme.toolbarTintColor = self.accentColor;
    theme.toolbarTintDisabledColor = [self.accentColor colorWithAlphaComponent:0.5];
    
    theme.toolbarDetailBackgroundColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.15 * isLight];
    theme.toolbarDetailTintColor = self.accentColor;
    
    theme.searchBackgroundColor = self.backgroundColor;
    theme.searchFieldBackgroundColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.1];
    
    theme.searchTintColor = self.mainColor;
    theme.searchPlaceholderColor = [self.mainColor colorWithAlphaComponent:0.6];
    
    theme.tableSeparatorColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.02 * isLight];
    
    theme.cellTintColor = self.accentColor;
    theme.cellBackgroundColor = self.contentColor;
    theme.cellSelectedBackgroundColor = [self.contentColor alpha_colorWithBrightnessModifier:-0.05 * isLight];
    theme.cellTitleColor = self.textColor;
    theme.cellSubtitleColor = [self.textColor colorWithAlphaComponent:0.6];
    theme.cellDetailColor = self.accentColor;
    
    theme.tableHeaderBackgroundColor = [self.backgroundColor colorWithAlphaComponent:0.6];
    theme.tableHeaderFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.2 * isLight];
    theme.tableFooterBackgroundColor = [self.backgroundColor colorWithAlphaComponent:0.6];
    theme.tableFooterFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.2 * isLight];
    
    theme.tableHeaderGroupedBackgroundColor = self.backgroundColor;
    theme.tableHeaderGroupedFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.1 * isLight];
    theme.tableFooterGroupedBackgroundColor = self.backgroundColor;
    theme.tableFooterGroupedFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.1 * isLight];
    
    theme.fieldSeparatorColor = theme.tableSeparatorColor;
    theme.fieldInputBackgroundColor = self.contentColor;
    theme.fieldInputBorderColor = [self.contentColor alpha_colorWithBrightnessModifier:-0.1 * isLight];
    
    theme.imageViewBorderColor = [self.contentColor alpha_colorWithBrightnessModifier:-0.1 * isLight];
    
    return theme;
}

+ (instancetype)defaultPalette
{
    ALPHAColorPalette *palette = [[ALPHAColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = [UIColor colorWithWhite:0.05 alpha:1.0];
    palette.accentColor = UIColorFromKey(@"#f7d746");
    palette.backgroundColor = UIColorFromKey(@"#1f1f1f");
    palette.contentColor = [UIColor colorWithWhite:0.02 alpha:1.0];
    palette.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    return palette;
}

@end
