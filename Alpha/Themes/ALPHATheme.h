//
//  ALPHATheme.h
//  Alpha
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

/*!
 *  Theme exposes colors and text attributes
 */
@interface ALPHATheme : NSObject

@property (nonatomic, readonly) NSDictionary *titleAttributes;

@property (nonatomic, readonly) UIColor *tintColor;

@property (nonatomic, readonly) UIColor *disabledTitleColor;

@property (nonatomic, readonly) UIColor *highlightedBackgroundColor;

@property (nonatomic, readonly) UIColor *selectedBackgroundColor;

@property (nonatomic, readonly) UIColor *defaultBackgroundColor;

@property (nonatomic) CGFloat topMargin;

/*!
 *  Returns new instance of the theme
 *
 *  @return ALPHATheme instance
 */
+ (instancetype)theme;

@end
