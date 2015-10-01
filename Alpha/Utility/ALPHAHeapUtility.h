//
//  ALPHAHeapUtility.h
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

typedef void (^ALPHAObjectEnumerationBlock)(__unsafe_unretained id object, __unsafe_unretained Class actualClass);

@interface ALPHAHeapUtility : NSObject

+ (void)enumerateLiveObjectsUsingBlock:(ALPHAObjectEnumerationBlock)block;

+ (id)objectForPointerString:(NSString *)pointerString className:(NSString *)className;

@end

#ifndef RH_OBJECTIVE_BEAGLE_H
#define RH_OBJECTIVE_BEAGLE_H 1

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    // ---------------------------------------------------------
    // Objective Beagle
    
    
    // instance search
    extern NSArray * beagle(NSString *className);       // shorthand for beagle_getInstancesOfClass()
    extern NSArray * beagle_exact(NSString *className); // shorthand for beagle_getInstancesOfExactClass()
    extern        id beagle_first(NSString *className); // shorthand for beagle_getFirstInstanceOfClass()
    
    // more verbose methods for those that enjoy typing
    extern NSArray * beagle_getInstancesOfClass(Class aClass);
    extern NSArray * beagle_getInstancesOfExactClass(Class aClass); // excludes subclasses from the result set
    extern        id beagle_getFirstInstanceOfClass(Class aClass);  // returns the first matching object found
    
    
    
    // class lookup
    extern NSArray * beagle_classes(NSString *partialName);     // shorthand for beagle_getClassesWithPrefix()
    extern NSArray * beagle_subclasses(NSString *className);    // shorthand for beagle_getSubclassesOfClass()
    
    // again, more verbose methods...
    extern NSArray * beagle_getClassesWithPrefix(NSString *prefix); // fetch classes that contain partialName in their name
    extern NSArray * beagle_getSubclassesOfClass(Class aClass);     // fetch a classes subclasses (Class objects, not instances)
    
    
    
    // category additions
    @interface NSObject (RHBeagleAdditions)

+ (NSArray *)beagle_instances;
+ (NSArray *)beagle_exactInstances;
+ (id)beagle_firstInstance;

// misc
+ (NSArray *)beagle_subclasses; // returns (Class) subclasses of the current class

@end
    
    
    
    // ---------------------------------------------------------
    // Objective Beagle - Implementation
    
    // options for RHFindInstancesOfClassWithOptions
    typedef NS_OPTIONS(NSUInteger, RHBeagleFindOptions) {
        RHBeagleFindOptionsDefault                    = 0UL,
        RHBeagleFindOptionFirstMatch                  = (1UL << 0), // return the first matching ([array count] == 1)
        RHBeagleFindOptionLastMatch                   = (1UL << 1), // return the last matching object ([array count] == 1)
        RHBeagleFindOptionExcludeSubclasses           = (1UL << 2), // prevent matching of subclasses
        RHBeagleFindOptionIncludeKnownUnsafeObjects   = (1UL << 3), // include known bad placeholder objects (ie __NSPlaceholderArray && __NSPlaceholderString) which raise exceptions
    };
    
    // search implementation
    extern NSArray * RHBeagleFindInstancesOfClassWithOptions(Class aClass, RHBeagleFindOptions options);
    
    // misc
    extern NSArray * RHBeagleGetSubclassesOfClass(Class aClass);
    extern NSArray * RHBeagleGetClassesWithNameAndOptions(NSString *partialName, NSStringCompareOptions options); //useful options include (NSCaseInsensitiveSearch, NSAnchoredSearch and NSBackwardsSearch)
    
    
    // ---------------------------------------------------------
    // Passthrough methods
    
    @interface NSObject (RHBeaglePassthroughAdditions)

- (id)beagle_ivarDescription;
- (id)beagle_methodDescription;
- (id)beagle_shortMethodDescription;

@end
    
#ifdef __cplusplus
}
#endif

#endif //end RH_OBJECTIVE_BEAGLE_H
