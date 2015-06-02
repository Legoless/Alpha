//
//  ALPHADataModel.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"
#import "ALPHAScreenSection.h"
#import "ALPHAScreenItem.h"
#import "ALPHAActionItem.h"

/*!
 *  Data Model wraps data displayed on a single screen
 */
@interface ALPHAScreenModel : NSObject <ALPHASerializableItem>

/*!
 *  Unique identifier by which to identify the model
 */
@property (nonatomic, copy) NSString *identifier;

/*!
 *  Specify expiration rate (default: 0 - no expiration) that model expires and 
 *  data source should be asked for new version.
 */
@property (nonatomic, assign) NSTimeInterval expiration;

/*!
 *  Title of data model which is usually displayed on top of navigation screen
 */
@property (nonatomic, copy) NSString *title;

/*!
 *  Action item that is usually displayed on top right of navigation bar
 */
@property (nonatomic, strong) ALPHAActionItem *rightAction;

/*!
 *  Array of display section objects objects
 */
@property (nonatomic, copy) NSArray *sections;

- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
