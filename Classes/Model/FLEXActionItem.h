//
//  FLEXActionItem.h
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

typedef void (^FLEXActionItemAction)(id sender);

/*!
 *  Action item of FLEX Context Menu
 */
@interface FLEXActionItem : NSObject

@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Currently supports NSString with Emoji or UIImage
 */
@property (nonatomic, strong) id icon;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* identifier;

/*!
 * Action to be executed when block is called.
 */
@property (nonatomic, copy) FLEXActionItemAction action;

/*!
 *  Convenience wrapper around alloc init
 *
 *  @param identifier
 *
 *  @return instance of action item
 */
+ (instancetype)itemWithIdentifier:(NSString *)identifier;

/*!
 *  Designated initializer
 *
 *  @param identifier Identifier of action, unique string
 *
 *  @return allocated action object
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
