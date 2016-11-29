//
//  NSObject+Runtime.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

+ (NSArray *)alpha_subclasses
{
    return [self alpha_subclassesOfClass:self];
}

- (NSArray *)alpha_subclasses
{
    return [[self class] alpha_subclassesOfClass:[self class]];
}

+ (NSArray *)alpha_subclassesOfClass:(Class)parentClass
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++) {
        Class superClass = classes[i];
        do
        {
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != parentClass);
        
        if (superClass == nil)
        {
            continue;
        }
        
        [result addObject:classes[i]];
    }
    
    free(classes);
    
    return [result copy];
}

@end
