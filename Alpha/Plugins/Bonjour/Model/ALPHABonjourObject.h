//
//  ALPHABonjourObject.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "ALPHASerialization.h"

/*!
 *  Underlying bonjour object that is transferred over the network.
 *  Bonjour source and server always communicate with this object.
 */
@interface ALPHABonjourObject : NSObject <NSCoding>

@property (nonatomic, copy) NSString* objectClass;
@property (nonatomic, copy) id objectData;

@property (nonatomic, copy) NSError *error;

/*!
 *  Prepares Bonjour object
 *
 *  @param object to be sent
 *
 *  @return
 */
- (instancetype)initWithObject:(id<ALPHASerializableItem>)object;

/*!
 *  Serializes object data and returns object
 *
 *  @return serialized object
 */
- (id<ALPHASerializableItem>)object;

@end
