//
//  ALPHAScreenItem.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

#import "ALPHASerializableItem.h"
#import "ALPHARequest.h"

typedef NSInteger ALPHAScreenItemPriority;

@interface ALPHAScreenItem : NSObject <ALPHASerializableItem>

#pragma mark - Model

/*!
 *  Back-Reference for model if created from a model
 */
@property (nonatomic, strong) id object;

#pragma mark - Screen

/*!
 *  NSString with Emoji or UIImage
 */
@property (nonatomic, strong) id icon;
@property (nonatomic, assign) UIViewContentMode imageContentMode;

- (NSString *)title;
- (void)setTitle:(id)title;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSAttributedString *attributedTitleText;

- (NSString *)detail;
- (void)setDetail:(id)detail;

@property (nonatomic, copy) NSString* detailText;
@property (nonatomic, copy) NSAttributedString* attributedDetailText;

@property (nonatomic, assign) UITableViewCellStyle style;

@property (nonatomic, assign) UITableViewCellAccessoryType accessory;

/*!
 *  Set this property to YES to render the screen item half transparent
 */
@property (nonatomic, assign) BOOL transparent;

/*!
 *  If any Alpha implemented cell class should be used instead of default.
 */
@property (nonatomic, copy) NSString *cellClass;

/*!
 *  If cell class is used, additional parameters can be set on cell class. The keys in dictionary
 *  correspond to properties in cell class.
 */
@property (nonatomic, copy) NSDictionary *cellParameters;

/*!
 *  Specified priority of the action item so the item is placed correctly in menus or table or collection
 */
@property (nonatomic, assign) ALPHAScreenItemPriority priority;

@end
