//
//  NSDictionary+Class.m
//

#import "NSDictionary+Class.h"

@implementation NSDictionary (Class)

- (BOOL)hay_containsObjectOfClass:(Class)objectClass
{
    for (id object in self.allValues)
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
    for (id object in self.allValues)
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
    for (id object in self.allValues)
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
    for (id object in self.allValues)
    {
        if (![object isKindOfClass:objectClass])
        {
            return NO;
        }
    }
    
    return YES;
}

@end
