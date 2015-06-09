//
//  ALPHARequest.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHARequest.h"

NSString *const ALPHAFileRequestIdentifier = @"com.unifiedsense.alpha.data.file.request";
NSString *const ALPHAFileURLParameterKey   = @"kALPHAFileURLParameterKey";

@interface ALPHARequest ()

@end

@implementation ALPHARequest

+ (instancetype)requestWithIdentifier:(NSString *)identifier
{
    return [[self alloc] initWithIdentifier:identifier];
}

+ (instancetype)requestWithIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters
{
    return [[self alloc] initWithIdentifier:identifier parameters:parameters];
}

+ (instancetype)requestForFile:(NSString *)fileURL
{
    return [self requestWithIdentifier:ALPHAFileRequestIdentifier parameters:@{ ALPHAFileURLParameterKey : fileURL }];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return [self initWithIdentifier:identifier parameters:nil];
}

- (id)copyWithZone:(NSZone *)zone;
{
    id object = [[self class] allocWithZone:zone];
    
    [object setIdentifier:[self.identifier copyWithZone:zone]];
    [object setParameters:[self.parameters copyWithZone:zone]];
    
    return object;
}

- (instancetype)initWithIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters
{
    self = [super init];
    
    if (self)
    {
        self.identifier = identifier;
        self.parameters = parameters;
    }
    
    return self;
}

- (BOOL)isEqual:(ALPHARequest *)object
{
    if (!object)
    {
        return NO;
    }
    
    if (![object isMemberOfClass:[self class]])
    {
        return NO;
    }
    
    return ([object.identifier isEqualToString:self.identifier] && [object.parameters isEqual:self.parameters]);
}

- (NSUInteger)hash
{
    return self.identifier.hash;
}

@end
