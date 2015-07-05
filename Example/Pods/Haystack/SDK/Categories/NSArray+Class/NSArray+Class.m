//
//  NSArray+Class.m
//

#import "NSArray+Class.h"

@implementation NSArray (Class)

- (id)hay_firstObjectOfClass:(Class)objectClass
{
    for (id object in self)
    {
        if ([object isMemberOfClass:objectClass])
        {
            return object;
        }
    }
    
    return nil;
}

- (id)hay_lastObjectOfClass:(Class)objectClass
{
    NSEnumerator *enumerator = self.reverseObjectEnumerator;
    
    for (id object in enumerator)
    {
        if ([object isMemberOfClass:objectClass])
        {
            return object;
        }
    }
    
    return nil;
}

- (BOOL)hay_containsObjectOfClass:(Class)objectClass
{
    for (id object in self)
    {
        if ([object isMemberOfClass:objectClass])
        {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)hay_containsObjectOfInheritedClass:(Class)objectClass
{
    for (id object in self)
    {
        if ([object isKindOfClass:objectClass])
        {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)hay_containsAllObjectsOfClass:(Class)objectClass
{
    for (id object in self)
    {
        if (![object isMemberOfClass:objectClass])
        {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)hay_containsAllObjectsOfInheritedClass:(Class)objectClass
{
    for (id object in self)
    {
        if (![object isKindOfClass:objectClass])
        {
            return NO;
        }
    }
    
    return YES;
}

@end
