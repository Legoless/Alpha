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

/*!
 *  Back-Reference for model if created from a model
 */
@property (nonatomic, weak) id model;

/*!
 *  NSString with Emoji or UIImage
 */
@property (nonatomic, strong) id icon;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) id detail;
@property (nonatomic, assign) UITableViewCellStyle style;

/*!
 *  Specified priority of the action item so the item is placed correctly in menus or table or collection
 */
@property (nonatomic, assign) ALPHAScreenItemPriority priority;

@end
