//
//  ALPHAInstanceSource.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"
#import "ALPHAUtility.h"
#import "ALPHAHeapUtility.h"

#import "ALPHATableScreenModel.h"

#import "ALPHAInstanceSource.h"

NSString* const ALPHAInstanceDataIdentifier = @"com.unifiedsense.alpha.data.instance";

NSString* const ALPHAInstanceDataReferenceObjectIdentifier = @"kALPHAInstanceDataReferenceObjectIdentifierKey";
NSString* const ALPHAInstanceDataClassNameIdentifier = @"kALPHAInstanceDataClassNameIdentifierKey";

@implementation ALPHAInstanceSource

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAInstanceDataIdentifier];
    }
    
    return self;
}

#pragma mark - ALPHABaseDataSource

/*!
 *  Override: Instance data source can only work if an object is provided for instances
 *
 *  @param request data request
 */
- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{
    if (!completion)
    {
        return;
    }
    
    [super hasDataForRequest:request completion:^(BOOL result)
    {
        BOOL hasData = result && (request.parameters[ALPHAInstanceDataClassNameIdentifier] != nil || request.parameters[ALPHAInstanceDataReferenceObjectIdentifier] != nil);
        
        completion(hasData);
    }];
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    //
    // We support only a single type of request
    //
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSDictionary *instanceData = nil;
    
    if (request.parameters[ALPHAInstanceDataClassNameIdentifier] && ! request.parameters[ALPHAInstanceDataReferenceObjectIdentifier])
    {
        instanceData = [self instancesForClassName:request.parameters[ALPHAInstanceDataClassNameIdentifier]];
    }
    else if (request.parameters[ALPHAInstanceDataReferenceObjectIdentifier] && request.parameters[ALPHAInstanceDataClassNameIdentifier])
    {
        instanceData = [self instancesReferencingObjectPointer:request.parameters[ALPHAInstanceDataReferenceObjectIdentifier] className:request.parameters[ALPHAInstanceDataClassNameIdentifier]];
    }
    
    NSInteger row = 0;
    
    for (id instance in instanceData[@"instances"])
    {
        
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.object = [ALPHARequest requestForObject:instance];
        
        NSString *title = nil;
        
        
        if (instanceData[@"fieldNames"] && (NSInteger)[instanceData[@"fieldNames"] count] > row)
        {
//            title = [NSString stringWithFormat:@"%@ %@", NSStringFromClass(object_getClass(instance)), [instanceData[@"fieldNames"] objectAtIndex:row]];
            title = NSStringFromClass(object_getClass(instance));
            item.detail = [instanceData[@"fieldNames"] objectAtIndex:row];
        }
        else
        {
            title = [NSString stringWithFormat:@"%@ %p", NSStringFromClass(object_getClass(instance)), instance];
            item.detail = [ALPHARuntimeUtility descriptionForIvarOrPropertyValue:instance];
        }
        
        item.title = title;
        if ([instanceData[@"instances"] isEqual:instance]) {
            item.cellParameters = @{@"backgroundColor":[UIColor redColor]};
        }
        item.style = UITableViewCellStyleSubtitle;
        
        row++;
        [items addObject:item];
    }
    
    //
    // Section & Model
    //
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAInstanceDataIdentifier];
    section.items = items.copy;
    
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAInstanceDataIdentifier];
    model.title = instanceData[@"title"];
    
    model.sections = @[ section ];

    return model;
}

#pragma mark - Private methods

- (NSDictionary *)instancesReferencingObjectPointer:(NSString *)pointer className:(NSString *)className
{
    id object = [ALPHAHeapUtility objectForPointerString:pointer className:pointer];
    
    if (!object)
    {
        return nil;
    }
    
    NSMutableArray *instances = [NSMutableArray array];
    NSMutableArray *fieldNames = [NSMutableArray array];
    
    [ALPHAHeapUtility enumerateLiveObjectsUsingBlock:^(__unsafe_unretained id tryObject, __unsafe_unretained Class actualClass) {
        // Get all the ivars on the object. Start with the class and and travel up the inheritance chain.
        // Once we find a match, record it and move on to the next object. There's no reason to find multiple matches within the same object.
        Class tryClass = actualClass;

        while (tryClass)
        {
            unsigned int ivarCount = 0;
            Ivar *ivars = class_copyIvarList(tryClass, &ivarCount);
            for (unsigned int ivarIndex = 0; ivarIndex < ivarCount; ivarIndex++
                    )
            {
                Ivar ivar = ivars[ivarIndex];
                const char *typeEncoding = ivar_getTypeEncoding(ivar);
                if (typeEncoding[0] == @encode(id)[0] || typeEncoding[0] == @encode(Class)[0])
                {
                    ptrdiff_t offset = ivar_getOffset(ivar);
                    uintptr_t *fieldPointer = (__bridge void *) tryObject + offset;
                    if (*fieldPointer == (uintptr_t) (__bridge void *) object)
                    {
                        [instances addObject:tryObject];
                        [fieldNames addObject:@(ivar_getName(ivar))];
                        return;
                    }
                }
            }
            tryClass = class_getSuperclass(tryClass);
        }
    }];
    
    return @{ @"instances" : instances.copy, @"fieldNames" : fieldNames.copy, @"title" : [NSString stringWithFormat:@"Referencing %@ %p", NSStringFromClass(object_getClass(object)), object] };
}

- (NSDictionary *)instancesForClassName:(NSString *)className
{
    const char *classNameCString = [className UTF8String];
    NSMutableArray *instances = [NSMutableArray array];
    
    [ALPHAHeapUtility enumerateLiveObjectsUsingBlock:^(__unsafe_unretained id object, __unsafe_unretained Class actualClass) {
        if (strcmp(classNameCString, class_getName(actualClass)) == 0)
        {
            // Note: objects of certain classes crash when retain is called. It is up to the user to avoid tapping into instance lists for these classes.
            // Ex. OS_dispatch_queue_specific_queue
            // In the future, we could provide some kind of warning for classes that are known to be problematic.

            if (object)
            {
                [instances addObject:object];
            }
        }
    }];

    return @{ @"instances" : instances.copy, @"title" : [NSString stringWithFormat:@"%@ (%lu)", className, (unsigned long)[instances count]] };
}


@end
