//
//  FLEXTheme.h
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@interface FLEXTheme : NSObject

@property (nonatomic, readonly) NSDictionary *titleAttributes;

@property (nonatomic, readonly) UIColor *defaultTitleColor;

@property (nonatomic, readonly) UIColor *disabledTitleColor;

@property (nonatomic, readonly) UIColor *highlightedBackgroundColor;

@property (nonatomic, readonly) UIColor *selectedBackgroundColor;

@property (nonatomic, readonly) UIColor *defaultBackgroundColor;

@property (nonatomic)  CGFloat topMargin;

@end
