//
//  NSObject+ALPHASerialization.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializerManager.h"
#import "ALPHAJSONSerializer.h"

#import "NSObject+ALPHASerialization.h"

@implementation NSObject (ALPHASerialization)

+ (NSArray *)arrayOfObjectsWithDictionaries:(NSArray *)dictionaries
{
    return [self arrayOfObjectsWithDictionaries:dictionaries error:nil];
}

+ (NSArray *)arrayOfObjectsWithDictionaries:(NSArray *)dictionaries error:(NSError **)error
{
    return [[ALPHASerializerManager sharedManager].serializer deserializeObject:dictionaries toClass:self];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    return [self initWithDictionary:dictionary error:nil];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    return [[ALPHASerializerManager sharedManager].serializer deserializeObject:dictionary toClass:[self class]];
}

- (NSDictionary *)toDictionary
{
    return [[ALPHASerializerManager sharedManager].serializer serializeObject:self];
}

#pragma mark - JSON

- (instancetype)initWithJSONData:(NSData *)data
{
    return [self initWithJSONData:data error:nil];
}

- (instancetype)initWithJSONData:(NSData *)data error:(NSError **)error
{
    ALPHAJSONSerializer* serializer = [[ALPHASerializerManager sharedManager].serializer isKindOfClass:[ALPHAJSONSerializer class]] ? [ALPHASerializerManager sharedManager].serializer : nil;
    
    return [serializer deserializeObjectFromJSONData:data toClass:[self class]];
}

- (instancetype)initWithJSONString:(NSString *)JSONString
{
    return [self initWithJSONString:JSONString error:nil];
}

- (instancetype)initWithJSONString:(NSString *)JSONString error:(NSError **)error
{
    ALPHAJSONSerializer* serializer = [[ALPHASerializerManager sharedManager].serializer isKindOfClass:[ALPHAJSONSerializer class]] ? [ALPHASerializerManager sharedManager].serializer : nil;
    
    return [serializer deserializeObjectFromJSONString:JSONString toClass:[self class]];
}

- (NSData *)toJSONData
{
    ALPHAJSONSerializer* serializer = [[ALPHASerializerManager sharedManager].serializer isKindOfClass:[ALPHAJSONSerializer class]] ? [ALPHASerializerManager sharedManager].serializer : nil;
    
    return [serializer serializeObjectToJSONData:self];
}

- (NSString *)toJSONString
{
    ALPHAJSONSerializer* serializer = [[ALPHASerializerManager sharedManager].serializer isKindOfClass:[ALPHAJSONSerializer class]] ? [ALPHASerializerManager sharedManager].serializer : nil;
    
    return [serializer serializeObjectToJSONString:self];
}

@end
