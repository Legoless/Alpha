//
//  NSInvocation+Argument.m
//

@import ObjectiveC.runtime;

#import "NSInvocation+Argument.h"

@implementation NSInvocation (Argument)

- (id)hay_objectAtIndex:(NSInteger)index
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
