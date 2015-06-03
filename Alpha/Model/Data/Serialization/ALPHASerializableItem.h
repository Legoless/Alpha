//
//  ALPHASerializableItem.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "NSObject+ALPHASerialization.h"

/*!
 *  All objects that implement this protocol can be serialized to a BLOB, string, JSON or property list
 *  for network transfer. Just conform to protocol that should be used for serialization. All protocols
 *  are implemented using a category on NSObject, so all methods are optional and do not need to be implemented.
 *  Serializable items can be nested.
 *
 *  Serialization is based on Object Map and JSONModel code and ideas.
 *  
 *  When nesting arrays of objects, create protocol with same object name and make array conform to it
 *  in definition (no methods required) and serializer will automatically serialize the array.
 *
 *  Serializable items support all objects that are supported by property list:
 *   - NSArray
 *   - NSDictionary
 *   - NSString
 *   - NSData
 *   - NSDate
 *   - NSNumber (int, double, bool)
 *
 *  In addition to property list types, serializable items also handle primitive properties of type:
 *   - NSInteger -> (NSNumber)
 *   - double    -> (NSNumber)
 *   - BOOL      -> (NSNumber)
 *   - UIImage   -> (NSData PNG)
 *   - Enums     -> (NSNumber)
 *   - Bitmasks  -> (NSNumber)
 *
 *  All other properties are ignored, since automatic serialization is not possible. Create readonly computed 
 *  properties with getters to serialize other specific properties that depend on certain variables.
 *
 *  JSON Serialization reencodes certain types:
 *   - NSData   -> (NSString Base64)
 *   - NSDate   -> (NSString UTC "yyyy-MM-dd'T'HH:mm:ss.SSS")
 *
 */
@protocol ALPHASerializableItem <NSObject>

@optional

+ (NSArray *)arrayOfObjectsWithDictionaries:(NSArray *)dictionaries;
+ (NSArray *)arrayOfObjectsWithDictionaries:(NSArray *)dictionaries error:(NSError **)error;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary error:(NSError **)error;

- (NSDictionary *)toDictionary;

@end

@protocol ALPHAJSONSerializableItem <ALPHASerializableItem>

@optional

- (instancetype)initWithJSONData:(NSData *)data;
- (instancetype)initWithJSONData:(NSData *)data error:(NSError **)error;

- (instancetype)initWithJSONString:(NSString *)JSONString;
- (instancetype)initWithJSONString:(NSString *)JSONString error:(NSError **)error;

- (NSString *)toJSONString;

- (NSData *)toJSONData;

@end