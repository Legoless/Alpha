//
//  ALPHAColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

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
    CGFloat isLight = ([self.contentColor alpha_brightness] >= 0.5) ? 1.0 : -1.0;
    CGFloat isStatusLight = ([self.accentColor alpha_brightness] >= 0.5) ? 1.0 : -1.0;
    
    theme.statusBarStyle = isStatusLight > 0 ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
    theme.keyboardAppearance = isLight > 0.0 ? UIKeyboardAppearanceLight : UIKeyboardAppearanceDark;
    
    //
    // Set colors
    //
    theme.backgroundColor = self.backgroundColor;
    theme.mainColor = self.contentTintColor;
    theme.headerTitleColor = self.accentColor;
    theme.headerButtonColor = self.accentColor;
    
    theme.headerBackgroundColor = self.mainColor;
    theme.headerShadowColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.05 * isLight];
    theme.notificationBackgroundColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.05 * isLight];
    theme.notificationTintColor = self.accentColor;
    
    theme.menuBackgroundColor = self.mainColor;
    theme.menuTintColor = self.accentColor;
    theme.menuButtonBackgroundColor = [theme.menuBackgroundColor colorWithAlphaComponent:0.9];
    theme.menuButtonSelectedBackgroundColor = [self.mainColor alpha_colorWithBrightnessModifier:0.1];
    
    theme.toolbarBackgroundColor = self.mainColor;
    theme.toolbarSelectedColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.15 * isLight];
    theme.toolbarHighlightedColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.2 * isLight];
    
    theme.toolbarTintColor = self.accentColor;
    theme.toolbarTintDisabledColor = [self.accentColor colorWithAlphaComponent:0.5];
    
    theme.toolbarDetailBackgroundColor = [self.mainColor alpha_colorWithBrightnessModifier:-0.15 * isLight];
    theme.toolbarDetailTintColor = self.accentColor;
    
    theme.searchBackgroundColor = self.backgroundColor;
    theme.searchFieldBackgroundColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.05];
    
    theme.searchTintColor = self.contentTintColor;
    theme.searchPlaceholderColor = [self.contentTintColor colorWithAlphaComponent:0.6];
    
    theme.tableSeparatorColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.03 * isLight];
    
    theme.cellTintColor = self.contentTintColor;
    theme.cellBackgroundColor = self.contentColor;
    theme.cellSelectedBackgroundColor = [self.contentColor alpha_colorWithBrightnessModifier:-0.05 * isLight];
    theme.cellTitleColor = self.textColor;
    theme.cellSubtitleColor = [self.textColor colorWithAlphaComponent:0.6];
    theme.cellDetailColor = self.contentTintColor;
    
    theme.tableHeaderBackgroundColor = [self.backgroundColor colorWithAlphaComponent:0.8];
    theme.tableHeaderFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.25 * isLight];
    theme.tableFooterBackgroundColor = [self.backgroundColor colorWithAlphaComponent:0.8];
    theme.tableFooterFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.25 * isLight];
    
    theme.tableHeaderGroupedBackgroundColor = self.backgroundColor;
    theme.tableHeaderGroupedFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.25 * isLight];
    theme.tableFooterGroupedBackgroundColor = self.backgroundColor;
    theme.tableFooterGroupedFontColor = [self.backgroundColor alpha_colorWithBrightnessModifier:-0.25 * isLight];
    
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
    palette.accentColor = ALPHAColorFromKey(@"#f7d746");
    palette.contentTintColor = palette.accentColor;
    palette.backgroundColor = [UIColor colorWithWhite:0.06 alpha:1.0];
    palette.contentColor = [UIColor colorWithWhite:0.02 alpha:1.0];
    palette.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    return palette;
}

@end
