//
//  NSInvocation+Argument.m
//

#import <objc/runtime.h>

#import "NSInvocation+Argument.h"

@implementation NSInvocation (Argument)

- (id)hs_argumentAtIndex:(NSInteger)index
{
    id object;
    
    [self getArgument:&object atIndex:index];
    
    if (object)
    {
        return object;
    }
    
    return nil;
}

@end
