//
//  ALPHAObjectSource.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <objc/runtime.h>

#import "ALPHAObjectProperty.h"
#import "ALPHAObjectIvar.h"
#import "ALPHAObjectMethod.h"

#import "FLEXUtility.h"
#import "FLEXRuntimeUtility.h"

#import "ALPHAObjectModel.h"
#import "ALPHAObjectSource.h"

NSString *const ALPHAObjectDataIdentifier = @"com.unifiedsense.alpha.data.object";

@interface ALPHAObjectSource ()

@end

@implementation ALPHAObjectSource

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAObjectDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    id object = nil;
    
    //
    // First find the referenced object
    //
    if (request.parameters[ALPHAObjectDataPointerIdentifier] && request.parameters[ALPHAObjectDataClassNameIdentifier])
    {
        object = [self objectForPointerString:request.parameters[ALPHAObjectDataPointerIdentifier] className:request.parameters[ALPHAObjectDataClassNameIdentifier]];
    }
    
    if (!object)
    {
        return nil;
    }
    
    NSString *search = request.parameters[ALPHASearchTextParameterKey];
    BOOL includeInheritance = [request.parameters[ALPHASearchScopeParameterKey] boolValue];
    
    //
    // Search & Inheritence included when generating object model
    //
    
    ALPHAObjectModel *model = [[ALPHAObjectModel alloc] initWithIdentifier:ALPHAObjectDataIdentifier];
    
    model.request = request;
    
    model.objectClass = NSStringFromClass([object class]);
    model.objectDescription = [FLEXUtility safeDescriptionForObject:object];
    
    model.objectContent = [self contentWithObject:object];
    model.objectMainSuperclass = [self mainSuperclassForObject:object];
    
    model.properties = [self propertiesWithObject:object search:search inheritance:includeInheritance];
    model.ivars = [self ivarsWithObject:object search:search inheritance:includeInheritance];
    model.methods = [self methodsWithObject:object search:search inheritance:includeInheritance];
    model.classMethods = [self classMethodsWithObject:object search:search inheritance:includeInheritance];
    model.superclasses = [self superclassesWithObject:object search:search];
    
    return model;
}

#pragma mark - Object content

- (ALPHAObjectContent *)contentWithObject:(id)object
{
    //
    // Currently handled specific Foundation objects
    // - NSArray
    // - NSUserDefaults
    // - NSDictionary
    // - NSSet
    // - NSOrderedSet
    //
    
    if ([object isKindOfClass:[NSArray class]])
    {
        return [ALPHAObjectContent objectContentForArray:object];
    }
    else if ([object isKindOfClass:[NSSet class]])
    {
        return [ALPHAObjectContent objectContentForSet:object];
    }
    else if ([object isKindOfClass:[NSDictionary class]])
    {
        return [ALPHAObjectContent objectContentForDictionary:object];
    }
    else if ([object isKindOfClass:[NSOrderedSet class]])
    {
        return [ALPHAObjectContent objectContentForOrderedSet:object];
    }
    else if ([object isKindOfClass:[NSUserDefaults class]])
    {
        return [ALPHAObjectContent objectContentForUserDefaults:object];
    }
    
    return nil;
}

- (NSString *)mainSuperclassForObject:(id)object
{
    //
    // If object is a class object, we return specific value
    //
    if (class_isMetaClass(object_getClass(object)))
    {
        return nil;
    }
    
    if (object_isClass(object))
    {
        return nil;
    }
    
    NSArray *mainSuperclassPrefixes = @[ @"NS", @"UI", @"CA" ];
    
    Class class = [object superclass];
    
    while (![mainSuperclassPrefixes containsObject:[FLEXRuntimeUtility prefixOfClassName: NSStringFromClass(class)]])
    {
        class = [class superclass];
    }
    
    if (class)
    {
        return NSStringFromClass(class);
    }
    
    return nil;
}

#pragma mark - Properties

- (NSArray *)propertiesWithObject:(id)object search:(NSString *)search inheritance:(BOOL)inheritance
{
    Class class = [object class];
    NSArray *properties = [[self class] propertiesForClass:class onObject:object];
    
    if (inheritance)
    {
        NSArray *inheritedProperties = [[self class] inheritedPropertiesForClass:class onObject:object];
        properties = [properties arrayByAddingObjectsFromArray:inheritedProperties];
    }
    
    if ([search length] > 0)
    {
        NSMutableArray *mutableUnsortedFilteredProperties = [NSMutableArray array];
        
        for (ALPHAObjectProperty *propertyBox in properties)
        {
            if ([propertyBox.propertyName rangeOfString:search options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [mutableUnsortedFilteredProperties addObject:propertyBox];
            }
        }
        
        properties = mutableUnsortedFilteredProperties;
    }
    
    return [properties sortedArrayUsingComparator:^NSComparisonResult(ALPHAObjectProperty *propertyBox1, ALPHAObjectProperty *propertyBox2)
    {
        NSString *name1 = propertyBox1.propertyName;
        NSString *name2 = propertyBox2.propertyName;
        return [name1 caseInsensitiveCompare:name2];
    }];
}

+ (NSArray *)propertiesForClass:(Class)class onObject:(id)object
{
    NSMutableArray *boxedProperties = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &propertyCount);
    
    if (propertyList)
    {
        for (unsigned int i = 0; i < propertyCount; i++)
        {
            ALPHAObjectProperty *propertyBox = [[ALPHAObjectProperty alloc] init];
            propertyBox.propertyName = [NSString stringWithUTF8String:property_getName(propertyList[i])];
            propertyBox.propertyType = [FLEXRuntimeUtility prettyTypeForProperty:propertyList[i]];
            
            if (!class_isMetaClass(object_getClass(object)))
            {
                propertyBox.propertyValue = [FLEXRuntimeUtility descriptionForIvarOrPropertyValue:[FLEXRuntimeUtility valueForProperty:propertyList[i] onObject:object]];
            }
            
            [boxedProperties addObject:propertyBox];
        }
        
        free (propertyList);
    }
    
    return boxedProperties;
}

+ (NSArray *)inheritedPropertiesForClass:(Class)class onObject:(id)object
{
    NSMutableArray *inheritedProperties = [NSMutableArray array];
    
    while ((class = [class superclass]))
    {
        [inheritedProperties addObjectsFromArray:[self propertiesForClass:class onObject:object]];
    }
    
    return inheritedProperties;
}

#pragma mark - Ivars

- (NSArray *)ivarsWithObject:(id)object search:(NSString *)search inheritance:(BOOL)inheritance
{
    Class class = [object class];
    NSArray *ivars = [[self class] ivarsForClass:class onObject:object];
    NSArray *inheritedIvars = [[self class] inheritedIvarsForClass:class onObject:object];
    
    if (inheritance)
    {
        ivars = [ivars arrayByAddingObjectsFromArray:inheritedIvars];
    }
    
    if ([search length] > 0)
    {
        NSMutableArray *mutableUnsortedFilteredIvars = [NSMutableArray array];
        
        for (ALPHAObjectIvar *ivarBox in ivars)
        {
            if ([ivarBox.ivarName rangeOfString:search options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [mutableUnsortedFilteredIvars addObject:ivarBox];
            }
        }
        
        ivars = mutableUnsortedFilteredIvars;
    }
    
    return [ivars sortedArrayUsingComparator:^NSComparisonResult(ALPHAObjectIvar *ivarBox1, ALPHAObjectIvar *ivarBox2)
    {
        NSString *name1 = ivarBox1.ivarName;
        NSString *name2 = ivarBox2.ivarName;
        return [name1 caseInsensitiveCompare:name2];
    }];
}

+ (NSArray *)ivarsForClass:(Class)class onObject:(id)object
{
    NSMutableArray *boxedIvars = [NSMutableArray array];
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList(class, &ivarCount);
    
    if (ivarList)
    {
        for (unsigned int i = 0; i < ivarCount; i++)
        {
            ALPHAObjectIvar *ivarBox = [[ALPHAObjectIvar alloc] init];
            ivarBox.ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
            ivarBox.ivarType = [FLEXRuntimeUtility prettyTypeForIvar:ivarList[i]];
            
            if (!class_isMetaClass(object_getClass(object)) && ![ivarBox.ivarType isEqualToString:@"Class"])
            {
                ivarBox.ivarValue = [FLEXRuntimeUtility descriptionForIvarOrPropertyValue:[FLEXRuntimeUtility valueForIvar:ivarList[i] onObject:object]];
            }
            
            [boxedIvars addObject:ivarBox];
        }
        
        free (ivarList);
    }
    
    return boxedIvars;
}

+ (NSArray *)inheritedIvarsForClass:(Class)class onObject:(id)object
{
    NSMutableArray *inheritedIvars = [NSMutableArray array];
    
    while ((class = [class superclass]))
    {
        [inheritedIvars addObjectsFromArray:[self ivarsForClass:class onObject:object]];
    }
    
    return inheritedIvars;
}

#pragma mark - Methods

- (NSArray *)methodsWithObject:(id)object search:(NSString *)search inheritance:(BOOL)inheritance
{
    Class class = [object class];
    NSArray *methods = [[self class] methodsForClass:class areClassMethods:NO];
    NSArray *inheritedMethods = [[self class] inheritedMethodsForClass:class areClassMethods:NO];
    
    return [self filteredMethodsFromMethods:methods inheritedMethods:inheritedMethods areClassMethods:NO search:search inheritance:inheritance];
}

- (NSArray *)classMethodsWithObject:(id)object search:(NSString *)search inheritance:(BOOL)inheritance
{
    const char *className = [NSStringFromClass([object class]) UTF8String];
    Class metaClass = objc_getMetaClass(className);
    
    NSArray *classMethods = [[self class] methodsForClass:metaClass areClassMethods:YES];
    NSArray *inheritedClassMethods = [[self class] inheritedMethodsForClass:metaClass areClassMethods:YES];
    
    return [self filteredMethodsFromMethods:classMethods inheritedMethods:inheritedClassMethods areClassMethods:YES search:search inheritance:inheritance];
}

- (NSArray *)filteredMethodsFromMethods:(NSArray *)methods inheritedMethods:(NSArray *)inheritedMethods areClassMethods:(BOOL)areClassMethods search:(NSString *)search inheritance:(BOOL)inheritance
{
    NSArray *candidateMethods = methods;
    
    if (inheritance)
    {
        candidateMethods = [candidateMethods arrayByAddingObjectsFromArray:inheritedMethods];
    }
    
    if ([search length] > 0)
    {
        NSMutableArray *mutableUnsortedFilteredMethods = [NSMutableArray array];
        
        for (ALPHAObjectMethod *methodBox in candidateMethods)
        {
            if ([methodBox.methodName rangeOfString:search options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [mutableUnsortedFilteredMethods addObject:methodBox];
            }
        }
        
        candidateMethods = mutableUnsortedFilteredMethods;
    }
    
    return [candidateMethods sortedArrayUsingComparator:^NSComparisonResult(ALPHAObjectMethod *methodBox1, ALPHAObjectMethod *methodBox2)
    {
        NSString *name1 = methodBox1.methodName;
        NSString *name2 = methodBox2.methodName;
        return [name1 caseInsensitiveCompare:name2];
    }];
}


+ (NSArray *)methodsForClass:(Class)class areClassMethods:(BOOL)areClassMethods
{
    NSMutableArray *boxedMethods = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    
    if (methodList)
    {
        for (unsigned int i = 0; i < methodCount; i++)
        {
            ALPHAObjectMethod *methodBox = [[ALPHAObjectMethod alloc] init];
            methodBox.methodName = NSStringFromSelector(method_getName(methodList[i]));
            methodBox.methodReturnType = [FLEXRuntimeUtility prettyReturnTypeForMethod:methodList[i]];
            methodBox.arguments = [FLEXRuntimeUtility prettyArgumentComponentsForMethod:methodList[i]];
            methodBox.isClassMethod = areClassMethods;
            
            [boxedMethods addObject:methodBox];
        }
        
        free(methodList);
    }
    return boxedMethods;
}

+ (NSArray *)inheritedMethodsForClass:(Class)class areClassMethods:(BOOL)areClassMethods
{
    NSMutableArray *inheritedMethods = [NSMutableArray array];
    
    while ((class = [class superclass]))
    {
        [inheritedMethods addObjectsFromArray:[self methodsForClass:class areClassMethods:areClassMethods]];
    }
    
    return inheritedMethods;
}

#pragma mark - Superclasses

+ (NSArray *)superclassesForClass:(Class)class
{
    NSMutableArray *superClasses = [NSMutableArray array];
    
    while ((class = [class superclass]))
    {
        [superClasses addObject:NSStringFromClass(class)];
    }
    
    return superClasses;
}

- (NSArray *)superclassesWithObject:(id)object search:(NSString *)search
{
    NSArray *superclasses = [[self class] superclassesForClass:[object class]];
    
    if ([search length] > 0)
    {
        NSMutableArray *filteredSuperclasses = [NSMutableArray array];
        
        for (NSString *superclass in superclasses)
        {
            if ([superclass rangeOfString:search options:NSCaseInsensitiveSearch].length > 0) {
                [filteredSuperclasses addObject:superclass];
            }
        }
        
        superclasses = filteredSuperclasses;
    }
    
    return superclasses;
}


#pragma mark - Private methods

- (id)objectForPointerString:(NSString *)pointerString className:(NSString *)className
{
    __unsafe_unretained id object;
    sscanf([pointerString cStringUsingEncoding:NSUTF8StringEncoding], "%p", &object);
    
    Class objectClass = NSClassFromString(className);
    
    if ([object class] == objectClass)
    {
        return object;
    }
    
    return nil;
}

@end
