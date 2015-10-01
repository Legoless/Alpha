//
//  ALPHAHeapSource.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHAHeapUtility.h"
#import "ALPHAUtility.h"

#import "ALPHAInstanceSource.h"

#import "ALPHAHeapSource.h"

#import "ALPHAScreenModel.h"
#import "ALPHATableScreenModel.h"

NSString* const ALPHAHeapDataIdentifier = @"com.unifiedsense.alpha.data.heap";

@implementation ALPHAHeapSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAHeapDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    NSDictionary *classes = [self heapClasses];
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSUInteger totalCount = 0;
    
    NSArray *classNames = nil;
    
    NSUInteger sortIndex = 0;
    
    if (request.parameters[ALPHASearchScopeParameterKey])
    {
        sortIndex = [request.parameters[ALPHASearchScopeParameterKey] unsignedIntegerValue];
    }
    
    if ([request.parameters[ALPHASearchTextParameterKey] length] > 0)
    {
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", request.parameters[ALPHASearchTextParameterKey]];
        classNames = [classes.allKeys filteredArrayUsingPredicate:searchPredicate];
    }
    else
    {
        classNames = classes.allKeys;
    }
    
    if (sortIndex == 0)
    {
        classNames = [classNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    }
    else
    {
        classNames = [classNames sortedArrayUsingComparator:^NSComparisonResult(NSString *className1, NSString *className2)
        {
            NSNumber *count1 = [classes objectForKey:className1];
            NSNumber *count2 = [classes objectForKey:className2];

            return [count2 compare:count1];
        }];
    }
    
    for (NSString *className in classNames)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        
        NSNumber *count = classes[className];
        item.title = [NSString stringWithFormat:@"%@ (%ld)", className, (long)[count longValue]];
        item.object = [ALPHARequest requestWithIdentifier:ALPHAInstanceDataIdentifier parameters:@{ ALPHAInstanceDataClassNameIdentifier : className }];
        
        totalCount += [count unsignedIntegerValue];
        
        [items addObject:item];
    }
    
    //
    // Section & Model
    //
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAHeapDataIdentifier];
    section.items = items.copy;
    
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAHeapDataIdentifier];
    model.title = [NSString stringWithFormat:@"Live Objects (%lu)", (unsigned long)totalCount];
    
    model.searchBarPlaceholder = @"Filter";
    model.scopes = @[ @"Sort Alphabetically", @"Sort by Count" ];
    
    model.sections = @[ section ];
    model.expiration = 60;
    
    return model;
}

#pragma mark - Private methods

- (NSDictionary *)heapClasses
{
    // Set up a CFMutableDictionary with class pointer keys and NSUInteger values.
    // We abuse CFMutableDictionary a little to have primitive keys through judicious casting, but it gets the job done.
    // The dictionary is intialized with a 0 count for each class so that it doesn't have to expand during enumeration.
    // While it might be a little cleaner to populate an NSMutableDictionary with class name string keys to NSNumber counts,
    // we choose the CF/primitives approach because it lets us enumerate the objects in the heap without allocating any memory during enumeration.
    // The alternative of creating one NSString/NSNumber per object on the heap ends up polluting the count of live objects quite a bit.
    unsigned int classCount = 0;
    Class *classes = objc_copyClassList(&classCount);
    CFMutableDictionaryRef mutableCountsForClasses = CFDictionaryCreateMutable(NULL, classCount, NULL, NULL);
    
    for (unsigned int i = 0; i < classCount; i++)
    {
        CFDictionarySetValue(mutableCountsForClasses, (__bridge const void *)classes[i], (const void *)0);
    }
    
    // Enumerate all objects on the heap to build the counts of instances for each class.
    [ALPHAHeapUtility enumerateLiveObjectsUsingBlock:^(__unsafe_unretained id object, __unsafe_unretained Class actualClass) {
        NSUInteger instanceCount = (NSUInteger) CFDictionaryGetValue(mutableCountsForClasses, (__bridge const void *) actualClass);
        instanceCount++;
        CFDictionarySetValue(mutableCountsForClasses, (__bridge const void *) actualClass, (const void *) instanceCount);
    }];
    
    // Convert our CF primitive dictionary into a nicer mapping of class name strings to counts that we will use as the table's model.
    NSMutableDictionary *mutableCountsForClassNames = [NSMutableDictionary dictionary];
    for (unsigned int i = 0; i < classCount; i++) {
        Class class = classes[i];
        NSUInteger instanceCount = (NSUInteger)CFDictionaryGetValue(mutableCountsForClasses, (__bridge const void *)(class));
        if (instanceCount > 0) {
            NSString *className = @(class_getName(class));
            [mutableCountsForClassNames setObject:@(instanceCount) forKey:className];
        }
    }
    free(classes);
    
    return mutableCountsForClassNames;
}

@end
