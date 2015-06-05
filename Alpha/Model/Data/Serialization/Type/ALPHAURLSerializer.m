//
//  ALPHAURLSerializer.m
//  Alpha
//
//  Created by Dal Rupnik on 05/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAURLSerializer.h"

@implementation ALPHAURLSerializer

- (Class)type
{
    return [NSURL class];
}

- (id)serializeObject:(id)object
{
    if ([object isKindOfClass:[NSURL class]])
    {
        return [object absoluteString];
    }
    
    return nil;
}

- (id)deserializeObject:(id)object toClass:(Class)objectClass
{
    if ([objectClass isKindOfClass:[NSURL class]] && [object isKindOfClass:[NSString class]])
    {
        return [NSURL URLWithString:object];
    }
    
    return nil;
}

@end
