//
//  ALPHAObjectSource.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHAActions.h"

#import "ALPHAObjectActionItem.h"
#import "ALPHAObjectProperty.h"
#import "ALPHAObjectIvar.h"
#import "ALPHAObjectMethod.h"

#import "ALPHAHeapUtility.h"
#import "ALPHARuntimeUtility.h"

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
    
    NSString *search = request.parameters[ALPHASearchTextParameterKey];
    BOOL includeInheritance = [request.parameters[ALPHASearchScopeParameterKey] boolValue];
    
    //
    // Search & Inheritence included when generating object model
    //
    
    id object = nil;
    
    if (request.parameters[ALPHAObjectDataPointerIdentifier] && request.parameters[ALPHAObjectDataClassNameIdentifier])
    {
        object = [ALPHAHeapUtility objectForPointerString:request.parameters[ALPHAObjectDataPointerIdentifier] className:request.parameters[ALPHAObjectDataClassNameIdentifier]];
    }

    if (!object)
    {
        return nil;
    }
    
    ALPHAObjectModel *model = [[ALPHAObjectModel alloc] initWithIdentifier:ALPHAObjectDataIdentifier];
    
    model.request = request;
    
    model.objectPointer = request.parameters[ALPHAObjectDataPointerIdentifier];
    model.objectClass = NSStringFromClass([object class]);
    model.objectDescription = [ALPHARuntimeUtility safeDescriptionForObject:object];
    
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
    
    while (![mainSuperclassPrefixes containsObject:[ALPHARuntimeUtility prefixOfClassName:NSStringFromClass(class)]])
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
        
        for (ALPHAObjectProperty *property in properties)
        {
            if ([property.name rangeOfString:search options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [mutableUnsortedFilteredProperties addObject:property];
            }
        }
        
        properties = mutableUnsortedFilteredProperties;
    }
    
    return [properties sortedArrayUsingComparator:^NSComparisonResult(ALPHAObjectProperty *property1, ALPHAObjectProperty *property2)
    {
        NSString *name1 = property1.name;
        NSString *name2 = property2.name;
        return [name1 caseInsensitiveCompare:name2];
    }];
}

+ (NSArray *)propertiesForClass:(Class)class onObject:(id)object
{
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &propertyCount);
    
    if (propertyList)
    {
        for (unsigned int i = 0; i < propertyCount; i++)
        {
            ALPHAObjectProperty *property = [[ALPHAObjectProperty alloc] init];
            property.name = [NSString stringWithUTF8String:property_getName(propertyList[i])];
            property.type.cType = [ALPHARuntimeUtility typeEncodingForProperty:propertyList[i]];
            property.type.name = [ALPHARuntimeUtility prettyTypeForProperty:propertyList[i]];
            property.attributes = [ALPHARuntimeUtility attributesDictionaryForProperty:propertyList[i]];
            
            if (!class_isMetaClass(object_getClass(object)))
            {
                property.value = [ALPHARuntimeUtility valueForProperty:propertyList[i] onObject:object];
            }
            
            [properties addObject:property];
        }
        
        free (propertyList);
    }
    
    return properties;
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
        
        for (ALPHAObjectIvar *ivar in ivars)
        {
            if ([ivar.name rangeOfString:search options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [mutableUnsortedFilteredIvars addObject:ivar];
            }
        }
        
        ivars = mutableUnsortedFilteredIvars;
    }
    
    return [ivars sortedArrayUsingComparator:^NSComparisonResult(ALPHAObjectIvar *ivar1, ALPHAObjectIvar *ivar2)
    {
        NSString *name1 = ivar1.name;
        NSString *name2 = ivar2.name;
        return [name1 caseInsensitiveCompare:name2];
    }];
}

+ (NSArray *)ivarsForClass:(Class)class onObject:(id)object
{
    NSMutableArray *ivars = [NSMutableArray array];
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList(class, &ivarCount);
    
    if (ivarList)
    {
        for (unsigned int i = 0; i < ivarCount; i++)
        {
            ALPHAObjectIvar *ivar = [[ALPHAObjectIvar alloc] init];
            ivar.name = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
            ivar.type.name = [ALPHARuntimeUtility prettyTypeForIvar:ivarList[i]];
            ivar.type.cType = [ALPHARuntimeUtility typeEncodingForIvar:ivarList[i]];
            
            if (!class_isMetaClass(object_getClass(object)) && ![ivar.type.name isEqualToString:@"Class"])
            {
                ivar.value = [ALPHARuntimeUtility valueForIvar:ivarList[i] onObject:object];
            }
            
            [ivars addObject:ivar];
        }
        
        free (ivarList);
    }
    
    return ivars;
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
        
        for (ALPHAObjectMethod *method in candidateMethods)
        {
            if ([method.name rangeOfString:search options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [mutableUnsortedFilteredMethods addObject:method];
            }
        }
        
        candidateMethods = mutableUnsortedFilteredMethods;
    }
    
    return [candidateMethods sortedArrayUsingComparator:^NSComparisonResult(ALPHAObjectMethod *method1, ALPHAObjectMethod *method2)
    {
        NSString *name1 = method1.name;
        NSString *name2 = method2.name;
        return [name1 caseInsensitiveCompare:name2];
    }];
}

+ (NSArray *)methodsForClass:(Class)class areClassMethods:(BOOL)areClassMethods
{
    NSMutableArray *methods = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    
    if (methodList)
    {
        for (unsigned int i = 0; i < methodCount; i++)
        {
            ALPHAObjectMethod *method = [[ALPHAObjectMethod alloc] init];
            method.name = NSStringFromSelector(method_getName(methodList[i]));
            
            char *returnType = method_copyReturnType(methodList[i]);
            
            method.returnType.name = [ALPHARuntimeUtility prettyReturnTypeForMethod:methodList[i]];
            method.returnType.cType = @(returnType);
            
            free (returnType);
            
            method.arguments = (NSArray<ALPHAObjectArgument> *)[self argumentListForMethod:methodList[i]];
            method.isClassMethod = areClassMethods;
            
            [methods addObject:method];
        }
        
        free(methodList);
    }
    return methods;
}

+ (NSArray *)argumentListForMethod:(Method)method
{
    NSMutableArray *components = [NSMutableArray array];
    
    NSString *selectorName = NSStringFromSelector(method_getName(method));
    NSArray *selectorComponents = [selectorName componentsSeparatedByString:@":"];
    unsigned int numberOfArguments = method_getNumberOfArguments(method);
    
    for (unsigned int argIndex = ALPHANumberOfImplicitArgsKey; argIndex < numberOfArguments; argIndex++)
    {
        ALPHAObjectArgument *argument = [[ALPHAObjectArgument alloc] init];
        argument.name = selectorComponents[argIndex - ALPHANumberOfImplicitArgsKey];
        
        char *argType = method_copyArgumentType(method, argIndex);
        
        argument.type.cType = @(argType);
        argument.type.name = [ALPHARuntimeUtility readableTypeForEncoding:@(argType)];
        
        free(argType);
        
        [components addObject:argument];
    }
    
    return components;
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
            if ([superclass rangeOfString:search options:NSCaseInsensitiveSearch].length > 0)
            {
                [filteredSuperclasses addObject:superclass];
            }
        }
        
        superclasses = filteredSuperclasses;
    }
    
    return superclasses;
}

#pragma mark - Actions
-(void)canPerformAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestVerification)completion
{
    completion([action isKindOfClass:[ALPHAObjectActionItem class]]);
}

- (void)performAction:(ALPHAObjectActionItem *)action completion:(ALPHADataSourceRequestCompletion)completion
{
    //
    // Check if we have correct action to be performed
    //
    
    NSError *error;
    
    if (![action isKindOfClass:[ALPHAObjectActionItem class]])
    {
        error = [NSError errorWithDomain:@"com.unifiedsense.alpha.error" code:2 userInfo:@{ @"action" : action }];
    }
    
    //
    // First find the referenced object
    //
    
    id object = [ALPHAHeapUtility objectForPointerString:action.objectPointer className:action.objectClass];
    id returnObject = nil;
    
    if (!error && object)
    {
        returnObject = [self executeAction:action onObject:object withError:&error];
    }

    if (returnObject && ![returnObject isKindOfClass:[ALPHAModel class]])
    {
        ALPHARequest* request = [ALPHARequest requestForObject:returnObject];
        ALPHAObjectModel* objectModel = (ALPHAObjectModel *)[self modelForRequest:request];
        returnObject = objectModel;
    }
    
    //
    // Call completion
    //
    
    if (completion)
    {
        completion (returnObject, error);
    }
}

- (id)executeAction:(ALPHAObjectActionItem *)action onObject:(id)object withError:(NSError **)error;
{
    if (!object)
    {
        return nil;
    }
    
    //
    // Property setter calls, method calls, handling NSUserDefaults too
    //
    
    if (action.selector)
    {
        SEL selector = NSSelectorFromString(action.selector);
        return [ALPHARuntimeUtility performSelector:selector onObject:object withArguments:action.arguments error:error];
    }
    
    //
    // iVars
    //
    
    else if (action.ivar)
    {
        unsigned int ivarCount = 0;
        Ivar *ivarList = class_copyIvarList([object class], &ivarCount);
        
        Ivar ivar = NULL;
        
        if (ivarList)
        {
            for (unsigned int i = 0; i < ivarCount; i++)
            {
                NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
                
                if ([ivarName isEqualToString:action.ivar])
                {
                    ivar = ivarList[i];
                    
                    break;
                }
            }
            
            free (ivarList);
        }
        
        if (ivar != NULL)
        {
            [ALPHARuntimeUtility setValue:[action.arguments firstObject] forIvar:ivar onObject:object];
        }
    }
    else if (*error)
    {
        *error = [NSError errorWithDomain:@"com.unifedsense.alpha.error" code:3 userInfo:@{}];
    }
    
    return nil;
}

@end
