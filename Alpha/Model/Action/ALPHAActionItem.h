//
//  ALPHAActionItem.h
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAScreenItem.h"
#import "ALPHAIdentifiableItem.h"

/*!
 *  Action item
 */
@protocol ALPHAActionItem <NSObject>

@end

@interface ALPHAActionItem : ALPHAScreenItem <ALPHAIdentifiableItem>

@property (nonatomic, copy) ALPHARequest* request;

@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Convenience wrapper around alloc init
 *
 *  @param identifier action item identifier
 *
 *  @return instance of data item
 */
+ (instancetype)itemWithIdentifier:(NSString *)identifier;

- (instancetype)initWithRequest:(ALPHARequest *)request;

- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier style:(UITableViewCellStyle)style;
- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail;
- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail style:(UITableViewCellStyle)style;

@end
