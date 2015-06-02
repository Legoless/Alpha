//
//  ALPHAActionItem.h
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAScreenItem.h"
#import "ALPHAIdentifiableItem.h"

/*!
 *  Action item
 */
@interface ALPHAActionItem : ALPHAScreenItem <ALPHAIdentifiableItem>

@property (nonatomic, copy) NSString* identifier;

@property (nonatomic, getter = isEnabled) BOOL enabled;

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
