//
//  ALPHAColorPalette.h
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "ALPHATheme.h"

@interface ALPHAColorPalette : NSObject

#pragma mark - Fonts

/*!
 *  Font Family used for:
 *  - Navigation bar and Buttons
 *  - Toolbar
 *  - Notification overlay
 */
@property (nonatomic, strong) NSString *headerFontFamily;

/*!
 *  Font Family used for all content.
 */
@property (nonatomic, strong) NSString *contentFontFamily;

#pragma mark - Colors

/*!
 *  Primary color is used for:
 *   - Navigation bar background
 *   - Main menu tint
 *   - Toolbar icon tint
 *   -
 */
@property (nonatomic, strong) UIColor *mainColor;

/*!
 *  Accent color should be in contrast with primary color and is used for:
 *   - Menu background
 *   - Toolbar background
 *   - Text on navigation bar
 */
@property (nonatomic, strong) UIColor *accentColor;

/*!
 *  Background color is used for:
 *   - Background of view controllers
 *   - Table view section color
 *   - Search bar
 *   - Table view separators
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/*!
 *  Content color is used for:
 *   - Table view cell content
 *   - Input field content
 */
@property (nonatomic, strong) UIColor *contentColor;

/*!
 *  Text color on content, must have large contrast with content and background color
 */
@property (nonatomic, strong) UIColor *textColor;

#pragma mark - Default

+ (instancetype)defaultPalette;

#pragma mark - Convenience methods

/*!
 *  Returns a new instance of theme using color palette
 *
 *  @return theme instance
 */
- (ALPHATheme *)paletteTheme;

@end
