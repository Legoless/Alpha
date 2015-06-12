//
//  ALPHAObjectItem.h
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

@protocol ALPHAObjectItem <NSObject>

@end

/*!
 *  Wraps items in dictionaries arrays or sets
 */
@interface ALPHAObjectItem : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *className;

@property (nonatomic, copy) NSString *pointer;

@end
