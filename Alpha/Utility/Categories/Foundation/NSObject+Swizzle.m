//
//  NSObject+Swizzle.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "NSObject+Swizzle.h"

@implementation NSObject (Swizzle)

+ (void)alpha_swizzleInstanceMethod:(SEL)firstMethod withMethod:(SEL)secondMethod {
    @synchronized (self) {
        Class class = [self class];
        
        [[self class] alpha_swizzleInstanceMethod:firstMethod withMethod:secondMethod inClass:class];
    }
}

+ (void)alpha_swizzleInstanceMethod:(SEL)firstMethod withMethod:(SEL)secondMethod inClass:(Class)class {
    SEL originalSelector = firstMethod;
    SEL swizzledSelector = secondMethod;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)alpha_swizzleClassMethod:(SEL)firstMethod withMethod:(SEL)secondMethod {
    @synchronized (self) {
        Class class = object_getClass((id)self);
        
        [self alpha_swizzleClassMethod:firstMethod withMethod:secondMethod inClass:class];
    }
}

+ (void)alpha_swizzleClassMethod:(SEL)firstMethod withMethod:(SEL)secondMethod inClass:(Class)class {
    SEL originalSelector = firstMethod;
    SEL swizzledSelector = secondMethod;
    
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
