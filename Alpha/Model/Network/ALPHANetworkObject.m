//
//  ALPHANetworkObject.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

NSString *const ALPHANetworkObjectVerificationKey = @"kALPHANetworkObjectVerificationKey";

#import "ALPHASerialization.h"

#import "ALPHANetworkObject.h"

@interface ALPHANetworkObject ()

@property (nonatomic, strong) id<ALPHASerializer> serializer;

@end

@implementation ALPHANetworkObject

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (id<ALPHASerializer>)serializer
{
    if (!_serializer)
    {
        _serializer = [ALPHASerializerManager sharedManager];
    }
    
    return _serializer;
}

- (instancetype)initWithObject:(id<ALPHASerializableItem>)object
{
    self = [super init];
    
    if (self)
    {
        self.objectClass = NSStringFromClass([object class]);
        self.objectData = [self.serializer serializeObject:object];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.objectClass forKey:@"objectClass"];
    [aCoder encodeObject:self.objectData forKey:@"objectData"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        self.objectClass = [aDecoder decodeObjectForKey:@"objectClass"];
        self.objectData = [aDecoder decodeObjectForKey:@"objectData"];
    }
    
    return self;
}

- (id<ALPHASerializableItem>)object
{
    return [self.serializer deserializeObject:self.objectData toClass:NSClassFromString(self.objectClass)];
}

@end
