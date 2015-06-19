//
//  ALPHATheme.h
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAFont.h"
#import "ALPHAColorPalette.h"

/*!
 *  Theme exposes colors and text attributes that is reflected throughout Alpha
 */
@interface ALPHATheme : NSObject

#pragma mark - Global

/*!
 *  Global background color, used on most view controllers
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/*!
 *  Main color used for Alpha UI (default tintColor)
 */
@property (nonatomic, strong) UIColor *mainColor;

/*!
 *  Status bar style used on theme
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/*!
 *  Content font family
 */
@property (nonatomic, strong) NSString *contentFontFamily;

#pragma mark - Navigation Bar

/*!
 *  Navigation bar font family
 */
@property (nonatomic, strong) ALPHAFont *headerTitleFont;
@property (nonatomic, strong) ALPHAFont *headerButtonFont;

@property (nonatomic, strong) UIColor *headerTitleColor;
@property (nonatomic, strong) UIColor *headerButtonColor;

/*!
 *  Navigation bar background color
 */
@property (nonatomic, strong) UIColor *headerBackgroundColor;
@property (nonatomic, strong) UIColor *headerShadowColor;

#pragma mark - Notification Overlay Bar

@property (nonatomic, strong) UIColor *notificationBackgroundColor;
@property (nonatomic, strong) UIColor *notificationTintColor;
@property (nonatomic, strong) ALPHAFont *notificationFont;

#pragma mark - Main Menu

/*!
 *  Usually matches background color
 */
@property (nonatomic, strong) UIColor *menuBackgroundColor;

/*!
 *  Usually matches mainColor
 */
@property (nonatomic, strong) UIColor *menuTintColor;

@property (nonatomic, strong) UIColor *menuButtonBackgroundColor;
@property (nonatomic, strong) UIColor *menuButtonSelectedBackgroundColor;

#pragma mark - Toolbar

/*!
 *  Top icon margin
 */
@property (nonatomic, assign) CGFloat topMargin;

/*!
 *  Usually matches menu background color
 */
@property (nonatomic, strong) UIColor *toolbarBackgroundColor;
@property (nonatomic, strong) UIColor *toolbarSelectedColor;
@property (nonatomic, strong) UIColor *toolbarDisabledColor;

/*!
 *  Usually matches menu tint color
 */
@property (nonatomic, strong) UIColor *toolbarTintColor;

@property (nonatomic, strong) ALPHAFont *toolbarTitleFont;

#pragma mark - Search & Segment Bar

@property (nonatomic, strong) UIColor *searchBackgroundColor;
@property (nonatomic, strong) UIColor *searchFieldBackgroundColor;

/*!
 *  Usually main color, for segment color
 */
@property (nonatomic, strong) UIColor *searchTintColor;

@property (nonatomic, strong) UIColor *searchPlaceholderColor;

/*!
 *  Applied to both segments (scopes) and search box
 */
@property (nonatomic, strong) ALPHAFont *searchBarFont;

#pragma mark - Table View General

@property (nonatomic, strong) UIColor *tableSeparatorColor;

#pragma mark - Table View Cell

@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;

@property (nonatomic, strong) UIColor *cellTitleColor;

/*!
 *  Cell subtitle color (when cell is in subtitle style)
 */
@property (nonatomic, strong) UIColor *cellSubtitleColor;

/*!
 *  Cell detail color (when cell is in detail style)
 */
@property (nonatomic, strong) UIColor *cellDetailColor;

#pragma mark - Table View Plain

@property (nonatomic, strong) UIColor *tableHeaderBackgroundColor;
@property (nonatomic, strong) UIColor *tableHeaderFontColor;
@property (nonatomic, strong) ALPHAFont *tableHeaderFont;

@property (nonatomic, strong) UIColor *tableFooterBackgroundColor;
@property (nonatomic, strong) UIColor *tableFooterFontColor;
@property (nonatomic, strong) ALPHAFont *tableFooterFont;

#pragma mark - Table View Grouped

/*!
 *  Grouped table view uses default background color, so specify font and colors here
 */
@property (nonatomic, strong) UIColor *tableHeaderGroupedFontColor;
@property (nonatomic, strong) ALPHAFont *tableHeaderGroupedFont;

@property (nonatomic, strong) UIColor *tableFooterGroupedFontColor;
@property (nonatomic, strong) ALPHAFont *tableFooterGroupedFont;

#pragma mark - Initialization

- (instancetype)initWithColorPalette:(ALPHAColorPalette *)colorPalette;

/*!
 *  Factory - Returns new instance of the theme
 *
 *  @return ALPHATheme instance
 */
+ (instancetype)theme;

+ (instancetype)themeWithColorPalette:(ALPHAColorPalette *)colorPalette;

/*!
 *  Called by the Alpha system once theme is initialized, will call UIAppearance
 *  protocols for correct elements.
 *
 *  @param window Alpha Window
 */
- (void)applyInWindow:(UIWindow *)window;

@end
