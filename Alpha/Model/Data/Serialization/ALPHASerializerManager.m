//
//  ALPHASerializerManager.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializerManager.h"
#import "ALPHAJSONSerializer.h"

#import "ALPHAImageSerializer.h"
#import "ALPHAURLSerializer.h"

@implementation ALPHASerializerManager

#pragma mark - Singleton

+ (instancetype)sharedManager
{
    static ALPHASerializerManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        ALPHAObjectSerializer* serializer = [[ALPHAJSONSerializer alloc] init];
        
        [serializer addTypeSerializer:[ALPHAImageSerializer new]];
        [serializer addTypeSerializer:[ALPHAURLSerializer new]];
        
        self.serializer = serializer;
    }
    
    return self;
}

- (id)serializeObject:(id)object
{
    return [self.serializer serializeObject:object];
}

- (id)deserializeObject:(id)object toClass:(Class)objectClass
{
    return [self.serializer deserializeObject:object toClass:objectClass];
}

@end
