//
//  ALPHAHeapUtility.m
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHAHeapUtility.h"
#import <malloc/malloc.h>
#import <mach/mach.h>

static CFMutableSetRef registeredClasses;

// Mimics the objective-c object stucture for checking if a range of memory is an object.
typedef struct {
    Class isa;
} ALPHAMaybeObject;

@implementation ALPHAHeapUtility

static kern_return_t memory_reader(task_t task, vm_address_t remote_address, vm_size_t size, void **local_memory)
{
    *local_memory = (void *)remote_address;
    return KERN_SUCCESS;
}

static void range_callback(task_t task, void *context, unsigned type, vm_range_t *ranges, unsigned rangeCount)
{
    ALPHAObjectEnumerationBlock block = (__bridge ALPHAObjectEnumerationBlock)context;
    if (!block) {
        return;
    }
    
    for (unsigned int i = 0; i < rangeCount; i++) {
        vm_range_t range = ranges[i];
        ALPHAMaybeObject *tryObject = (ALPHAMaybeObject *)range.address;
        Class tryClass = NULL;
#ifdef __arm64__
        // See http://www.sealiesoftware.com/blog/archive/2013/09/24/objc_explain_Non-pointer_isa.html
        extern uint64_t objc_debug_isa_class_mask WEAK_IMPORT_ATTRIBUTE;
        tryClass = (__bridge Class)((void *)((uint64_t)tryObject->isa & objc_debug_isa_class_mask));
#else
        tryClass = tryObject->isa;
#endif
        // If the class pointer matches one in our set of class pointers from the runtime, then we should have an object.
        if (CFSetContainsValue(registeredClasses, (__bridge const void *)(tryClass))) {
            block((__bridge id)tryObject, tryClass);
        }
    }
}

+ (void)enumerateLiveObjectsUsingBlock:(ALPHAObjectEnumerationBlock)block
{
    if (!block) {
        return;
    }
    
    // Refresh the class list on every call in case classes are added to the runtime.
    [self updateRegisteredClasses];
    
    // For another exmple of enumerating through malloc ranges (which helped my understanding of the api) see:
    // http://llvm.org/svn/llvm-project/lldb/tags/RELEASE_34/final/examples/darwin/heap_find/heap/heap_find.cpp
    // Also https://gist.github.com/samdmarshall/17f4e66b5e2e579fd396
    vm_address_t *zones = NULL;
    unsigned int zoneCount = 0;
    kern_return_t result = malloc_get_all_zones(mach_task_self(), &memory_reader, &zones, &zoneCount);
    if (result == KERN_SUCCESS) {
        for (unsigned int i = 0; i < zoneCount; i++) {
            malloc_zone_t *zone = (malloc_zone_t *)zones[i];
            if (zone->introspect && zone->introspect->enumerator) {
                zone->introspect->enumerator(mach_task_self(), (__bridge void *)(block), MALLOC_PTR_IN_USE_RANGE_TYPE, zones[i], &memory_reader, &range_callback);
            }
        }
    }
}

+ (void)updateRegisteredClasses
{
    if (!registeredClasses) {
        registeredClasses = CFSetCreateMutable(NULL, 0, NULL);
    } else {
        CFSetRemoveAllValues(registeredClasses);
    }
    unsigned int count = 0;
    Class *classes = objc_copyClassList(&count);
    for (unsigned int i = 0; i < count; i++) {
        CFSetAddValue(registeredClasses, (__bridge const void *)(classes[i]));
    }
    free(classes);
}

+ (id)objectForPointerString:(NSString *)pointerString className:(NSString *)className
{
    //
    // Do a class name check
    //
    
    if (!className)
    {
        return nil;
    }
    
    __block id tryObject = nil;
    
    Class objectClass = NSClassFromString(className);
    
    [self searchForPointerString:pointerString completion:^(id object)
    {
        if ([object class] == objectClass)
        {
            tryObject = object;
        }
        else
        {
            tryObject = [NSNull null];
        }
    }];
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (tryObject == nil)
        {
            [NSThread sleepForTimeInterval:0.01f];
        }
        
        if (tryObject == [NSNull null])
        {
            tryObject = nil;
        }
    });
    
    return tryObject;
}

+ (void)searchForPointerString:(NSString *)pointerString completion:(void (^)(id object))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
    {
        __block id object = nil;
        
        [self enumerateLiveObjectsUsingBlock:^(__unsafe_unretained id tryObject, __unsafe_unretained Class actualClass)
        {
            NSString *tryPointerString = [NSString stringWithFormat:@"%p", tryObject];
             
            if ([pointerString isEqualToString:tryPointerString])
            {
                object = tryObject;
            }
        }];
        
        if (completion)
        {
            completion(object);
        }
    });
}

@end

#include <objc/objc-api.h>
#include <objc/runtime.h>
#include <malloc/malloc.h>
#include <mach/mach.h>
#include <sys/sysctl.h>


#pragma mark internal - arc support

#if __has_feature(objc_arc)

#define arc_retain(x)       (x)
#define arc_release(x)
#define arc_autorelease(x)  (x)

#else

#define arc_retain(x)       ([x retain])
#define arc_release(x)      ([x release])
#define arc_autorelease(x)  ([x autorelease])

#ifndef __bridge
#define __bridge
#endif
#ifndef __bridge_retained
#define __bridge_retained
#endif
#ifndef __bridge_transfer
#define __bridge_transfer
#endif

#endif

#ifndef RH_OBJECTIVE_BEAGLE_M
#define RH_OBJECTIVE_BEAGLE_M 1

#pragma mark - internal - defines

#define OPTION_ENABLED(options, option) ((options & option) == option)
#define ROUND_TO_MULTIPLE(num, multiple) ((num) && (multiple) ? (num) + (multiple) - 1 - ((num) - 1) % (multiple) : 0)


static kern_return_t RHReadMemory(task_t task, vm_address_t remote_address, vm_size_t size, void **local_memory);
static void _RHZoneIntrospectionEnumeratorFindInstancesCallback(task_t task, void *baton, unsigned type, vm_range_t *ranges, unsigned count);
static size_t _RHBeagleSizeRoundedToNearestMallocRangeAllocationSize(size_t size);
extern NSArray * _RHBeagleFindInstancesOfClassWithOptionsInternal(Class aClass, RHBeagleFindOptions options);
static BOOL _RHBeagleIsKnownUnsafeClass(Class aClass);
static Class _RHBeagleClassFromString(NSString *className);


#pragma mark - public - instance search

NSArray * beagle(NSString *className) {
    Class aClass = _RHBeagleClassFromString(className);
    if (!aClass) return nil;
    return beagle_getInstancesOfClass(aClass);
}

NSArray * beagle_exact(NSString *className) {
    Class aClass = _RHBeagleClassFromString(className);
    if (!aClass) return nil;
    return beagle_getInstancesOfExactClass(aClass);
}

id beagle_first(NSString *className) {
    Class aClass = _RHBeagleClassFromString(className);
    if (!aClass) return nil;
    return beagle_getFirstInstanceOfClass(aClass);
}


#pragma mark - public - verbose instance search

NSArray * beagle_getInstancesOfClass(Class aClass) {
    return RHBeagleFindInstancesOfClassWithOptions(aClass, RHBeagleFindOptionsDefault);
}

NSArray * beagle_getInstancesOfExactClass(Class aClass) {
    return RHBeagleFindInstancesOfClassWithOptions(aClass, RHBeagleFindOptionExcludeSubclasses);
}

id beagle_getFirstInstanceOfClass(Class aClass) {
    //RHBeagleFindOptionFirstMatch only returns a single object, so its safe to use lastObject.
    return [RHBeagleFindInstancesOfClassWithOptions(aClass, RHBeagleFindOptionFirstMatch) lastObject];
}


#pragma mark - public - class search

extern NSArray * beagle_classes(NSString *partialName){
    return beagle_getClassesWithPrefix(partialName);
}

extern NSArray * beagle_subclasses(NSString *className) {
    Class aClass = _RHBeagleClassFromString(className);
    if (!aClass) return nil;
    return beagle_getSubclassesOfClass(aClass);
}


#pragma mark - public - verbose class search

NSArray * beagle_getSubclassesOfClass(Class aClass) {
    return RHBeagleGetSubclassesOfClass(aClass);
}

NSArray * beagle_getClassesWithPrefix(NSString *partialName){
    return RHBeagleGetClassesWithNameAndOptions(partialName, NSAnchoredSearch);
    
}


#pragma mark - public - RHObjectiveBeagleAdditions

@implementation NSObject (RHObjectiveBeagleAdditions)

+ (NSArray *)beagle_instances {
    return beagle_getInstancesOfClass([self class]);
}

+ (NSArray *)beagle_exactInstances {
    return beagle_getInstancesOfExactClass([self class]);
}

+ (id)beagle_firstInstance {
    return beagle_getFirstInstanceOfClass([self class]);
}

#pragma mark - misc
+ (id)beagle_subclasses {
    return RHBeagleGetSubclassesOfClass([self class]);
}

@end


#pragma mark - public - implementation

NSArray * RHBeagleFindInstancesOfClassWithOptions(Class aClass, RHBeagleFindOptions options) {
    
    //if someone has passed us a string, massage it into an actual class
    if ([(id)aClass isKindOfClass:[NSString class]]) {
        aClass = _RHBeagleClassFromString((NSString*)aClass);
    }
    
    //sanity check
    if (!aClass) {
        NSLog(@"RHBeagle: Error: class must not be NULL.");
        return nil;
    }
    
    return _RHBeagleFindInstancesOfClassWithOptionsInternal(aClass, options);
}


#pragma mark - public - misc

NSArray * RHBeagleGetSubclassesOfClass(Class query){
    int count = objc_getClassList(NULL, 0);
    if (count < 0) return nil;
    
    CFMutableArrayRef results = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    if (!results) return nil;
    
    if (count > 0) {
        Class *classes = (Class *)malloc(sizeof(Class) * count);
        count = objc_getClassList(classes, count);
        
        for (int i = 0; i < count; i++) {
            
            if (_RHBeagleIsKnownUnsafeClass(classes[i])){
                continue;
            }
            
            for (Class current = class_getSuperclass(classes[i]); current != NULL; current = class_getSuperclass(current)){
                if (current == query) {
                    CFArrayAppendValue(results, (__bridge void *)classes[i]);
                    break;
                }
            }
        }
        
        free(classes);
    }
    
    //cleanup
    CFArrayRef result = CFArrayCreateCopy(kCFAllocatorDefault, results);
    CFRelease(results);
    
    return arc_autorelease((__bridge_transfer NSArray *)result);
}

NSArray * RHBeagleGetClassesWithNameAndOptions(NSString *partialName, NSStringCompareOptions options){
    int count = objc_getClassList(NULL, 0);
    if (count < 0) return nil;
    
    CFMutableArrayRef results = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    if (!results) return nil;
    
    if (count > 0) {
        Class *classes = (Class *)malloc(sizeof(Class) * count);
        count = objc_getClassList(classes, count);
        
        for (int i = 0; i < count; i++) {
            Class current = classes[i];
            if ([NSStringFromClass(current) rangeOfString:partialName options:options].length > 0) {
                
                if (!_RHBeagleIsKnownUnsafeClass(current)){
                    CFArrayAppendValue(results, (__bridge void *)current);
                }
            }
        }
        
        free(classes);
    }
    
    //cleanup
    CFArrayRef result = CFArrayCreateCopy(kCFAllocatorDefault, results);
    CFRelease(results);
    
    return arc_autorelease((__bridge_transfer NSArray *)result);
}


#pragma mark - internal - implementation

//passed to _RHZoneIntrospectionEnumeratorFindInstancesCallback as baton
typedef struct _RHBeagleFindContext {
    Class query;
    CFArrayRef subclasses;
    CFMutableArrayRef results;
    NSUInteger options;
    BOOL canceled; //atm, only used in conjunction with option RHBeagleFindOptionFirstMatch
} RHBeagleFindContext;
typedef RHBeagleFindContext* RHBeagleFindContextRef;


static kern_return_t RHReadMemory(task_t task, vm_address_t remote_address, vm_size_t size, void **local_memory) {
    *local_memory = (void*) remote_address;
    return KERN_SUCCESS;
}

@interface _RHObjectStandin : NSObject @end
@implementation _RHObjectStandin @end

#pragma mark - internal - callback
static void _RHZoneIntrospectionEnumeratorFindInstancesCallback(task_t task, void *baton, unsigned type, vm_range_t *ranges, unsigned count) {
    RHBeagleFindContextRef context = (RHBeagleFindContextRef)baton;
    
    //bail if we have been canceled
    if (context->canceled){
        return;
    }
    
    for (unsigned i = 0; i < count; i++) {
        vm_range_t *range =  &ranges[i];
        
        size_t size = range->size;
        
        //make sure range is big enough to contain an an instance of an object
        if (size < class_getInstanceSize([_RHObjectStandin class])){
            continue;
        }
        
        //assume that ivars are pointer sized, allowing us to index into ivar territory
        uintptr_t *ivarPointers = (uintptr_t *)range->address;
        
#if defined(__arm64__)
        //MAGIC: for arm64 tagged isa pointers : (http://www.sealiesoftware.com/blog/archive/2013/09/24/objc_explain_Non-pointer_isa.html)
        //Note: We can't use object_getClass directly because we have no idea if the pointer is actually to an object or not at this point in time.
        extern uint64_t objc_debug_isa_class_mask WEAK_IMPORT_ATTRIBUTE;
        
        uint64_t taggedPointerMask;
        if (objc_debug_isa_class_mask == 0x0){
            //fall back to 0x00000001fffffff8 as of 19th May 2014; Not ABI stable..
            taggedPointerMask = 0x00000001fffffff8;
        } else {
            taggedPointerMask = objc_debug_isa_class_mask;
        }
        
        void * isa = (void *)(ivarPointers[0] & taggedPointerMask);
        
#elif (defined(__i386__) || defined(__x86_64__) || defined(__arm__))
        //regular stuff, on these known arcs.
        void * isa = (void *)ivarPointers[0];
#else
        //unknown arch. we need to be updated depending on whether or not the arch uses tagged isa pointers
#error Unknown architecture. We don't know if tagged isa pointers are used, therefore we can't continue.
#endif
        
        
        Class matchedClass = NULL;
        
        //check for a direct class pointer match
        if (isa == (__bridge void *)context->query){
            matchedClass = context->query;
        }
        
        //check for subclass pointer match
        if (!OPTION_ENABLED(context->options, RHBeagleFindOptionExcludeSubclasses) && context->subclasses) {
            CFIndex count = CFArrayGetCount(context->subclasses);
            for (CFIndex i = 0; i < count; i++) {
                Class possibleClass = CFArrayGetValueAtIndex(context->subclasses, i);
                if (isa == (__bridge void *)possibleClass) {
                    matchedClass = possibleClass;
                    break;
                }
            }
        }
        
        //bail on this zone if we didn't find a matching class pointer
        if (matchedClass == NULL){
            continue;
        }
        
        //remove "unsafe" classes from subclasses by default
        if (!OPTION_ENABLED(context->options, RHBeagleFindOptionIncludeKnownUnsafeObjects)) {
            if (_RHBeagleIsKnownUnsafeClass(matchedClass)){
                continue;
            }
        }
        
        
        //sanity check the zone size, making sure that it's the correct size for the classes instance size
        //malloc operates as per: http://www.cocoawithlove.com/2010/05/look-at-how-malloc-works-on-mac.html
        //therefore we need to round needed size to nearest quantum allocation size before comparing it to the ranges size
        
        size_t rounded = _RHBeagleSizeRoundedToNearestMallocRangeAllocationSize(class_getInstanceSize(matchedClass));
        if (rounded != size) continue;
        
        
        //if LastMatch; remove any previously added results (Not exactly optimal.. )
        if (OPTION_ENABLED(context->options, RHBeagleFindOptionLastMatch)){
            CFArrayRemoveAllValues(context->results);
        }
        
        void *matchedInstance = (void *)range->address;
        
        //add to results
        CFArrayAppendValue(context->results, matchedInstance);
        
        //if FirstMatch; cancel the remainder of our processing
        if (OPTION_ENABLED(context->options, RHBeagleFindOptionFirstMatch)){
            context->canceled = YES;
        }
    }
}

static size_t _RHBeagleSizeRoundedToNearestMallocRangeAllocationSize(size_t size) {
    
    //these next defines are from the last known malloc source: https://www.opensource.apple.com/source/Libc/Libc-825.40.1/gen/magazine_malloc.c (10.8.5) ( See : http://openradar.io/15365352 )
#define SHIFT_TINY_QUANTUM      4 // Required for AltiVec
#define	TINY_QUANTUM           (1 << SHIFT_TINY_QUANTUM)
    
#ifdef __LP64__
#define NUM_TINY_SLOTS          64	// number of slots for free-lists
#else
#define NUM_TINY_SLOTS          32	// number of slots for free-lists
#endif
    
    //these next ones are extracted from inlined logic spread throughout magazine_malloc.c (think tiny)
#define SMALL_THRESHOLD            ((NUM_TINY_SLOTS - 1) * TINY_QUANTUM)
#define LARGE_THRESHOLD			 (15 * 1024)
#define LARGE_THRESHOLD_LARGEMEM	(127 * 1024) //if greater than 1GB of ram, large uses this define
    
    
    static size_t _largeThreshold = LARGE_THRESHOLD;
    
    static dispatch_once_t _largeThresholdOnceToken;
    dispatch_once(&_largeThresholdOnceToken, ^{
        
        uint64_t	memsize = 0;
        size_t	uint64_t_size = sizeof(memsize);
        sysctlbyname("hw.memsize", &memsize, &uint64_t_size, 0, 0);
        
        if (memsize >= (1024*1024*1024)) {
            _largeThreshold = LARGE_THRESHOLD_LARGEMEM;
        }
        
    });
    
    
    if (size <= SMALL_THRESHOLD){
        //tiny; 16 bytes allocation
        return ROUND_TO_MULTIPLE(size, 16);
    } else if (size <= _largeThreshold){
        //small; 512 bytes allocation
        return ROUND_TO_MULTIPLE(size, 512);
    }
    
    //large; 4096 bytes allocation
    return ROUND_TO_MULTIPLE(size, 4096);
    
}

NSArray * _RHBeagleFindInstancesOfClassWithOptionsInternal(Class class, RHBeagleFindOptions options) {
    
    //grab the zones in the current process
    vm_address_t *zones = NULL;
    unsigned int count = 0;
    kern_return_t error = malloc_get_all_zones(0, &RHReadMemory, &zones, &count);
    if (error != KERN_SUCCESS){
        NSLog(@"[RHBeagle] Error: malloc_get_all_zones failed.");
        return nil;
    }
    
    
    //create our context object
    RHBeagleFindContext *context = calloc(sizeof(RHBeagleFindContext), 1);
    if (!context){
        NSLog(@"[RHBeagle] Error: failed to calloc memory for an RHBeagleFindContext struct.");
        return nil;
    }
    
    context->query = class;
    context->options = options;
    context->results = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    
    //subclasses
    CFArrayRef subclasses = (__bridge CFArrayRef)RHBeagleGetSubclassesOfClass(class);
    if (subclasses) context->subclasses = CFRetain(subclasses);
    
    for (unsigned i = 0; i < count; i++) {
        const malloc_zone_t *zone = (const malloc_zone_t *)zones[i];
        if (zone == NULL || zone->introspect == NULL){
            continue;
        }
        
        //for each zone, enumerate using our enumerator callback
        zone->introspect->enumerator(mach_task_self(), context, MALLOC_PTR_IN_USE_RANGE_TYPE, zones[i], &RHReadMemory, &_RHZoneIntrospectionEnumeratorFindInstancesCallback);
    }
    
    
    //cleanup RHBeagleFindContext
    NSArray *result = (__bridge NSArray *)CFArrayCreateCopy(kCFAllocatorDefault, context->results);
    
    if (context->subclasses) CFRelease(context->subclasses);
    if (context->results) CFRelease(context->results);
    free(context);
    
    //success
    return arc_autorelease(result);
}


static BOOL _RHBeagleIsKnownUnsafeClass(Class aClass) {
    NSString *className = NSStringFromClass(aClass);
    
    if ([@"_NSZombie_" isEqualToString:className]) return YES;
    if ([@"__ARCLite__" isEqualToString:className]) return YES;
    if ([@"__NSCFCalendar" isEqualToString:className]) return YES;
    if ([@"__NSCFTimer" isEqualToString:className]) return YES;
    if ([@"NSCFTimer" isEqualToString:className]) return YES;
    if ([@"__NSMessageBuilder" isEqualToString:className]) return YES;
    if ([@"__NSGenericDeallocHandler" isEqualToString:className]) return YES;
    if ([@"NSAutoreleasePool" isEqualToString:className]) return YES;
    if ([@"NSPlaceholderNumber" isEqualToString:className]) return YES;
    if ([@"NSPlaceholderString" isEqualToString:className]) return YES;
    if ([@"NSPlaceholderValue" isEqualToString:className]) return YES;
    if ([@"Object" isEqualToString:className]) return YES;
    if ([@"NSPlaceholderNumber" isEqualToString:className]) return YES;
    if ([@"VMUArchitecture" isEqualToString:className]) return YES;
    if ([className hasPrefix:@"__NSPlaceholder"]) return YES;
    
    return NO;
}

#define CLASS_SEARCH_THRESHOLD 3
#define CLASS_FUZZY_SEARCH_THRESHOLD 12

static Class _RHBeagleClassFromString(NSString *className) {
    if (className && ![className isKindOfClass:[NSString class]]) {
        return object_getClass((Class)className);
    }
    
    Class aClass = NSClassFromString(className);
    if (!aClass) {
        NSInteger classNameLength = [className length];
        if (classNameLength <= CLASS_SEARCH_THRESHOLD){
            NSLog(@"[RHBeagle] Error: Unknown class '%@'.", className);
            return nil;
        }
        
        //pseudo fuzzy mistyped class matching for longer class names
        NSString *fuzzyClassName = className;
        if (classNameLength > CLASS_FUZZY_SEARCH_THRESHOLD){
            fuzzyClassName = [fuzzyClassName substringWithRange:NSMakeRange(CLASS_SEARCH_THRESHOLD, classNameLength - (2 * CLASS_SEARCH_THRESHOLD))];
        }
        NSArray *possibleMatches = RHBeagleGetClassesWithNameAndOptions(fuzzyClassName, NSCaseInsensitiveSearch);
        
        NSString *question = [possibleMatches count] > 0 ? @"Perhaps you want one of these:" : @"";
        NSLog(@"[RHBeagle] Error: Unknown class '%@'. %@\n\t%@\n", className, question, [possibleMatches componentsJoinedByString:@"\n\t"]);
        
        return NULL;
    }
    
    return aClass;
}


#pragma mark - public - passthrough debug methods

#define SAFE_PASSTHROUGH( selectorName ) do { \
SEL selector = NSSelectorFromString(selectorName); \
if (![[self class] instancesRespondToSelector:selector]) return [NSString stringWithFormat:@"[RHBeagle] Error: Class '%@' does not implement instance method '%@'.", NSStringFromClass([self class]), selectorName]; \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
return [self performSelector:selector]; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation NSObject (RHBeaglePassthroughAdditions)

- (id)beagle_ivarDescription {
    SAFE_PASSTHROUGH(@"_ivarDescription");
}

- (id)beagle_methodDescription {
    SAFE_PASSTHROUGH(@"_methodDescription");
}

- (id)beagle_shortMethodDescription {
    SAFE_PASSTHROUGH(@"_shortMethodDescription");
}

@end

#endif //end RH_OBJECTIVE_BEAGLE_M

