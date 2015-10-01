//
//  ALPHATheme.h
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

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
 *  Keyboard appearance in Alpha fields
 */
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

#pragma mark - Navigation Bar

/*!
 *  Navigation bar font family
 */
@property (nonatomic, strong) UIFont *headerTitleFont;
@property (nonatomic, strong) UIFont *headerButtonFont;

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
@property (nonatomic, strong) UIFont *notificationFont;

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
@property (nonatomic, assign) CGFloat toolbarTopMargin;

/*!
 *  Usually matches menu background color
 */
@property (nonatomic, strong) UIColor *toolbarBackgroundColor;
@property (nonatomic, strong) UIColor *toolbarSelectedColor;
@property (nonatomic, strong) UIColor *toolbarHighlightedColor;

/*!
 *  Usually matches menu tint color
 */
@property (nonatomic, strong) UIColor *toolbarTintColor;
@property (nonatomic, strong) UIColor *toolbarTintDisabledColor;

@property (nonatomic, strong) UIFont *toolbarTitleFont;

/*!
 *  Toolbar optional detail
 */
@property (nonatomic, strong) UIColor *toolbarDetailBackgroundColor;
@property (nonatomic, strong) UIColor *toolbarDetailTintColor;
@property (nonatomic, strong) UIFont *toolbarDetailFont;

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
@property (nonatomic, strong) UIFont *searchBarFont;

#pragma mark - Table View General

@property (nonatomic, strong) UIColor *tableSeparatorColor;

#pragma mark - Table View Cell

@property (nonatomic, strong) UIColor *cellTintColor;

@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;

@property (nonatomic, strong) UIColor *cellTitleColor;

@property (nonatomic, strong) UIFont *cellTitleFont;
@property (nonatomic, strong) UIFont *cellSubtitleFont;
@property (nonatomic, strong) UIFont *cellDetailFont;

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
@property (nonatomic, strong) UIFont *tableHeaderFont;
@property (nonatomic, assign) CGFloat tableHeaderHeight;

@property (nonatomic, assign) UIEdgeInsets tableHeaderMargin;

@property (nonatomic, strong) UIColor *tableFooterBackgroundColor;
@property (nonatomic, strong) UIColor *tableFooterFontColor;
@property (nonatomic, strong) UIFont *tableFooterFont;
@property (nonatomic, assign) CGFloat tableFooterHeight;

@property (nonatomic, assign) UIEdgeInsets tableFooterMargin;

#pragma mark - Table View Grouped

/*!
 *  Grouped table view uses default background color, so specify font and colors here
 */
@property (nonatomic, strong) UIColor *tableHeaderGroupedBackgroundColor;
@property (nonatomic, strong) UIColor *tableHeaderGroupedFontColor;
@property (nonatomic, strong) UIFont *tableHeaderGroupedFont;

@property (nonatomic, assign) UIEdgeInsets tableHeaderGroupedMargin;
@property (nonatomic, assign) CGFloat tableHeaderGroupedHeight;

@property (nonatomic, strong) UIColor *tableFooterGroupedBackgroundColor;
@property (nonatomic, strong) UIColor *tableFooterGroupedFontColor;
@property (nonatomic, strong) UIFont *tableFooterGroupedFont;

@property (nonatomic, assign) UIEdgeInsets tableFooterGroupedMargin;
@property (nonatomic, assign) CGFloat tableFooterGroupedHeight;

#pragma mark - Field Editor

@property (nonatomic, strong) UIColor *fieldSeparatorColor;
@property (nonatomic, strong) UIColor *fieldTintColor;

@property (nonatomic, strong) UIFont *fieldTitleFont;
@property (nonatomic, strong) UIColor *fieldTitleColor;

@property (nonatomic, assign) CGFloat fieldTitleBottomMargin;

@property (nonatomic, strong) UIColor *fieldToolbarBackgroundColor;
@property (nonatomic, strong) UIColor *fieldToolbarTintColor;
@property (nonatomic, strong) UIFont *fieldToolbarFont;

#pragma mark - Text Editor

@property (nonatomic, strong) UIFont *fieldInputFont;
@property (nonatomic, strong) UIColor *fieldInputBackgroundColor;
@property (nonatomic, strong) UIColor *fieldInputBorderColor;
@property (nonatomic, assign) CGFloat fieldInputBorderWidth;

#pragma mark - Color Editor

@property (nonatomic, strong) UIFont *fieldColorFont;
@property (nonatomic, strong) UIFont *fieldColorComponentFont;

#pragma mark - Image Rendering

@property (nonatomic, strong) UIColor *imageViewBorderColor;
@property (nonatomic, assign) CGFloat imageViewBorderWidth;

#pragma mark - Initialization

/*!
 *  Factory - Returns new instance of the theme
 *
 *  @return ALPHATheme instance
 */
+ (instancetype)theme;

/*!
 *  Called by the Alpha system once theme is initialized, will call UIAppearance
 *  protocols for correct elements.
 *
 *  @param window Alpha Window
 */
- (void)applyInWindow:(UIWindow *)window;

#pragma mark - Utility methods

- (CGRect)rect:(CGRect)rect withMargin:(UIEdgeInsets)margin;

- (void)setFontsWithFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)size;

- (void)setHeaderFontsWithFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)size;

- (void)setContentFontsWithFamily:(NSString *)fontFamily defaultPointSize:(CGFloat)size;

@end
