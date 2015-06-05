//
//  ALPHAJSONSerializer.h
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectSerializer.h"

@interface ALPHAJSONSerializer : ALPHAObjectSerializer

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (NSData *)serializeObjectToJSONData:(id)object;
- (NSString *)serializeObjectToJSONString:(id)object;

- (id)deserializeObjectFromJSONData:(NSData *)object toClass:(Class)objectClass;
- (id)deserializeObjectFromJSONString:(NSString *)object toClass:(Class)objectClass;

@end
