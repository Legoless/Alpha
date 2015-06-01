//
//  ALPHATheme.h
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

/*!
 *  Theme exposes colors and text attributes that is reflected throughout Alpha
 */
@interface ALPHATheme : NSObject

#pragma mark - Global theme settings

@property (nonatomic, assign) CGFloat topMargin;

/*!
 *  Entire Alpha Interface is rendered with following font family
 */
@property (nonatomic, strong) NSString *fontFamily;

/*!
 *  Tint color used for Alpha UI
 */
@property (nonatomic, strong) UIColor *tintColor;

/*!
 *  Status bar style used on theme
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

#pragma mark - UI Global Settings

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;

@property (nonatomic, strong) UIColor *disabledTitleColor;

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


#pragma mark - Convenience methods

/*!
 *  Returns font of specified family of correct size
 *
 *  @param size of font
 *
 *  @return font instance
 */
- (UIFont *)themeFontOfSize:(CGFloat)size;

/*!
 *  Returns theme font with font-size taken from original font
 *
 *  @param font with size
 *
 *  @return font instance
 */
- (UIFont *)themeFontWithFont:(UIFont *)font;

@end
