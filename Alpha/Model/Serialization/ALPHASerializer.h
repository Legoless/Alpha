//
//  ALPHASerializer.h
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

@protocol ALPHASerializer <NSObject>

/*!
 *  Serializes object of type to property list based
 *
 *  @param object to serialize
 *
 *  @return serialized object
 */
- (id)serializeObject:(id)object;

/*!
 *  Deserialize object of any supported type
 *
 *  @param object deserialized object
 *  @param class target class
 *
 *  @return serialized object
 */
- (id)deserializeObject:(id)object toClass:(Class)objectClass;

@end
