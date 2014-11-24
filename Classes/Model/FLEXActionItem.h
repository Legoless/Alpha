//
//  FLEXActionItem.h
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

typedef void (^FLEXActionItemAction)(id sender);

@interface FLEXActionItem : NSObject

@property (nonatomic, getter = isEnabled) BOOL enabled;

@property (nonatomic, copy) UIImage* image;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* identifier;


/**
 * Action to be executed when blok is 
 */
@property (nonatomic, copy) FLEXActionItemAction action;

+ (instancetype)actionItemWithIdentifier:(NSString *)identifier;

/**
 *  Designated initializer
 *
 *  @param identifier Identifier of action, unique string
 *
 *  @return allocated action object
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
