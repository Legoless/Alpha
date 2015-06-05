//
//  ALPHAScreenItem.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

typedef NSInteger ALPHAScreenItemPriority;

@interface ALPHAScreenItem : NSObject <ALPHASerializableItem>

#pragma mark - Model

/*!
 *  Back-Reference for model if created from a model
 */
@property (nonatomic, strong) id object;

/*!
 *  File URL if item represents a file resource
 */
@property (nonatomic, copy) NSURL *file;
@property (nonatomic, strong) Class fileClass;

#pragma mark - Screen

/*!
 *  NSString with Emoji or UIImage
 */
@property (nonatomic, strong) id icon;

@property (nonatomic, strong) id title;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSAttributedString *attributedTitleText;

@property (nonatomic, strong) id detail;

@property (nonatomic, copy) NSString* detailText;
@property (nonatomic, copy) NSAttributedString* attributedDetailText;

@property (nonatomic, assign) UITableViewCellStyle style;

@property (nonatomic, assign) UITableViewCellAccessoryType accessory;

/*!
 *  Specified priority of the action item so the item is placed correctly in menus or table or collection
 */
@property (nonatomic, assign) ALPHAScreenItemPriority priority;

@end
