//
//  ALPHANetworkObject.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import Foundation;

/*!
 *  Set this key in parameters to true, if only check should be done.
 */
extern NSString *const ALPHANetworkObjectVerificationKey;

#import "ALPHASerialization.h"

/*!
 *  Underlying network object that is transferred over the network.
 *  Network sources and server bases always communicate using this object.
 */
@interface ALPHANetworkObject : NSObject

@property (nonatomic, copy) NSString* objectClass;
@property (nonatomic, copy) id objectData;

@property (nonatomic, copy) NSError *error;

@property (nonatomic, copy) NSDictionary *parameters;

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
