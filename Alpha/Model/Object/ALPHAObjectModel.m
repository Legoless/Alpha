//
//  ALPHAObjectModel.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectModel.h"
#import "ALPHAHeapUtility.h"

@implementation ALPHAObjectModel

- (void)setObjectPointer:(NSString *)objectPointer
{
    _objectPointer = objectPointer;
    id<NSObject> object = [ALPHAHeapUtility objectForPointerString:objectPointer className:nil];
    self->_objectIsClass = [object class] == object;
    
    [self updateReferencesWithObjectPointer:objectPointer objectClass:nil];
}

- (void)setObjectClass:(NSString *)objectClass
{
    _objectClass = objectClass;
    
    [self updateReferencesWithObjectPointer:nil objectClass:objectClass];
}

- (void)setProperties:(NSArray *)properties
{
    _properties = properties;
    
    [self updateReferences:_properties withObjectPointer:self.objectPointer objectClass:self.objectClass];
}

- (void)setIvars:(NSArray *)ivars
{
    _ivars = ivars;
    
    [self updateReferences:_ivars withObjectPointer:self.objectPointer objectClass:self.objectClass];
}

- (void)setMethods:(NSArray *)methods
{
    _methods = methods;
    
    [self updateReferences:_methods withObjectPointer:self.objectPointer objectClass:self.objectClass];
}

- (void)setClassMethods:(NSArray *)classMethods
{
    _classMethods = classMethods;
    
    [self updateReferences:_classMethods withObjectPointer:self.objectPointer objectClass:self.objectClass];
}

- (void)updateReferencesWithObjectPointer:(NSString *)objectPointer objectClass:(NSString *)className
{
    [self updateReferences:self.properties withObjectPointer:objectPointer objectClass:className];
    [self updateReferences:self.ivars withObjectPointer:objectPointer objectClass:className];
    [self updateReferences:self.methods withObjectPointer:objectPointer objectClass:className];
    [self updateReferences:self.classMethods withObjectPointer:objectPointer objectClass:className];
    [self updateReferences:self.properties withObjectPointer:objectPointer objectClass:className];
}

- (void)updateReferences:(NSArray *)array withObjectPointer:(NSString *)objectPointer objectClass:(NSString *)className
{
    for (id object in array)
    {
        if ([object respondsToSelector:@selector(setObjectClass:)] && objectPointer)
        {
            [object setObjectClass:className];
        }
        
        if ([object respondsToSelector:@selector(setObjectPointer:)] && className)
        {
            [object setObjectPointer:objectPointer];
        }
    }
}

@end
