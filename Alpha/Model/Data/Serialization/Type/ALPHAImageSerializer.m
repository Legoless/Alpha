//
//  ALPHAImageSerializer.m
//  Alpha
//
//  Created by Dal Rupnik on 05/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAImageSerializer.h"

@implementation ALPHAImageSerializer

- (Class)type
{
    return [UIImage class];
}

- (id)serializeObject:(id)object
{
    if ([object isKindOfClass:[UIImage class]])
    {
        return UIImagePNGRepresentation(object);
    }
    
    return nil;
}

- (id)deserializeObject:(id)object toClass:(Class)objectClass
{
    if ([object isKindOfClass:[NSData class]])
    {
        return [UIImage imageWithData:object];
    }
    
    return nil;
}

@end
