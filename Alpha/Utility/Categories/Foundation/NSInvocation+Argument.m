//
//  NSInvocation+Argument.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "NSInvocation+Argument.h"

@import ObjectiveC.runtime;

#import "NSInvocation+Argument.h"

@implementation NSInvocation (Argument)

- (id)alpha_objectAtIndex:(NSInteger)index {
    //
    // Protect against arguments out of bounds
    //
    NSMethodSignature * sig = [self methodSignatureForSelector:self.selector];
    
    if (index < [sig numberOfArguments]) {
        return nil;
    }
    
    void *tempPointer;
    
    [self getArgument:&tempPointer atIndex:index];
    
    if (tempPointer) {
        return (__bridge id)tempPointer;
    }
    
    return nil;
}

@end
