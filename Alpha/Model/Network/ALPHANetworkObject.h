//
//  ALPHANetworkObject.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

/*!
 *  Set this key in parameters to true, if only check should be done.
 */
extern NSString *const ALPHANetworkObjectVerificationKey;

#import "ALPHASerialization.h"
#import "ALPHARequest.h"

/*!
 *  Underlying network object that is transferred over the network.
 *  Network sources and server bases always communicate using this object.
 */
@interface ALPHANetworkObject : NSObject <ALPHASerializableItem>

@property (nonatomic, strong) id object;

@property (nonatomic, copy) NSError *error;

@property (nonatomic, copy) NSDictionary *parameters;

@end
