//
//  ALPHADisplayItem.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

typedef NSInteger ALPHADataItemPriority;

@interface ALPHADataItem : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString* identifier;

/*!
 *  Currently supports NSString with Emoji or UIImage
 */
@property (nonatomic, strong) id icon;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* detail;
@property (nonatomic, assign) UITableViewCellStyle style;

/*!
 *  Specified priority of the action item so the item is placed correctly in menus or table or collection
 */
@property (nonatomic, assign) ALPHADataItemPriority priority;

/*!
 *  Convenience wrapper around alloc init
 *
 *  @param identifier
 *
 *  @return instance of data item
 */
+ (instancetype)itemWithIdentifier:(NSString *)identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier style:(UITableViewCellStyle)style;
- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail;
- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail style:(UITableViewCellStyle)style;

@end
