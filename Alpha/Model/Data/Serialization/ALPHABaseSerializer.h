//
//  ALPHABaseSerializer.h
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializer.h"

@interface ALPHABaseSerializer : NSObject <ALPHASerializer>

#pragma mark - ALPHASerializer

- (id)serializeObject:(id)object;

- (id)deserializeObject:(id)object toClass:(Class)objectClass;

#pragma mark - Custom object serialization

//
// Those methods should be overriden if additional support for custom transformers
//

- (id)serializeCustomObject:(id)object;
- (id)deserializeCustomObject:(id)object toClass:(Class)objectClass;

#pragma mark - Static methods

+ (NSData *)base64DataFromString:(NSString *)string;
+ (NSString *)encodeBase64WithData:(NSData *)objData;

@end
