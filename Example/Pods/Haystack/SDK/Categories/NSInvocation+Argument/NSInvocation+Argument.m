//
//  NSInvocation+Argument.m
//

#import <objc/runtime.h>

#import "NSInvocation+Argument.h"

@implementation NSInvocation (Argument)

- (id)hs_objectAtIndex:(NSInteger)index
{
    //
    // Protect against arguments out of bounds
    //
    NSMethodSignature * sig = [self methodSignatureForSelector:self.selector];
    
    if (index < [sig numberOfArguments])
    {
        return nil;
    }
    
    void *tempPointer;
    
    [self getArgument:&tempPointer atIndex:index];
    
    if (tempPointer)
    {
        return (__bridge id)tempPointer;
    }
    
    return nil;
}

@end
