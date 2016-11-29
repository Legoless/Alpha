//
//  NSArray+Class.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "NSArray+Class.h"

@implementation NSArray (Class)

- (id)alpha_firstObjectOfClass:(Class)objectClass
{
    for (id object in self) {
        if ([object isMemberOfClass:objectClass]) {
            return object;
        }
    }
    
    return nil;
}

- (id)alpha_lastObjectOfClass:(Class)objectClass
{
    NSEnumerator *enumerator = self.reverseObjectEnumerator;
    
    for (id object in enumerator) {
        if ([object isMemberOfClass:objectClass]) {
            return object;
        }
    }
    
    return nil;
}

- (BOOL)alpha_containsObjectOfClass:(Class)objectClass
{
    for (id object in self) {
        if ([object isMemberOfClass:objectClass]) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)alpha_containsObjectOfInheritedClass:(Class)objectClass
{
    for (id object in self) {
        if ([object isKindOfClass:objectClass]) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)alpha_containsAllObjectsOfClass:(Class)objectClass
{
    for (id object in self) {
        if (![object isMemberOfClass:objectClass]) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)alpha_containsAllObjectsOfInheritedClass:(Class)objectClass
{
    for (id object in self) {
        if (![object isKindOfClass:objectClass]) {
            return NO;
        }
    }
    
    return YES;
}

@end
