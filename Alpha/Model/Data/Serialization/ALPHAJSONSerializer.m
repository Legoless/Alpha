//
//  ALPHAJSONSerializer.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAJSONSerializer.h"

#define ALPHADateFormat @"yyyy-MM-dd'T'HH:mm:ss.SSS"
#define ALPHATimeZone   @"UTC"

@implementation ALPHAJSONSerializer

#pragma mark - Getters and Setters

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = ALPHADateFormat;
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:ALPHATimeZone];
    }
    
    return _dateFormatter;
}

#pragma mark - ALPHABaseSerializer


- (id)serializeCustomObject:(id)object
{
    if ([object isKindOfClass:[NSData class]])
    {
        return [[self class] encodeBase64WithData:object];
    }
    
    if ([object isKindOfClass:[NSDate class]])
    {
        return [self.dateFormatter stringFromDate:object];
    }
    
    return [super serializeCustomObject:object];
}

- (id)deserializeCustomObject:(id)object toClass:(Class)objectClass
{
    if ([object isKindOfClass:[NSString class]] && objectClass == [NSData class])
    {
        return [[self class] base64DataFromString:object];
    }
    
    if ([object isKindOfClass:[NSString class]] && objectClass == [NSDate class])
    {
        return [self.dateFormatter dateFromString:object];
    }
    
    return [super deserializeCustomObject:object toClass:objectClass];
}

#pragma mark - Public Methods

- (NSData *)serializeObjectToJSONData:(id)object
{
    id serializedObject = [self serializeObject:object];
    
    NSData *jsonObject = [NSJSONSerialization dataWithJSONObject:serializedObject options:NSJSONWritingPrettyPrinted error:nil];
    
    return jsonObject;
}

- (NSString *)serializeObjectToJSONString:(id)object
{
    return [[NSString alloc] initWithData:[self serializeObjectToJSONData:object] encoding:NSUTF8StringEncoding];
}

- (id)deserializeObjectFromJSONData:(NSData *)object toClass:(Class)objectClass
{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingAllowFragments error:nil];
    
    return [self deserializeObject:jsonObject toClass:objectClass];
}

- (id)deserializeObjectFromJSONString:(NSString *)object toClass:(Class)objectClass
{
    return [self deserializeObjectFromJSONData:[object dataUsingEncoding:NSUTF8StringEncoding] toClass:objectClass];
}

@end
