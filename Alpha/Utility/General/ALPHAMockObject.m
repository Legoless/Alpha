//
//  ALPHAMockObject.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMockObject.h"

@implementation ALPHAMockObject

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSString* selector = NSStringFromSelector(aSelector);
    
    if ([super respondsToSelector:aSelector])
    {
        return YES;
    }
    else if ([self.trackedSelectors containsObject:selector])
    {
        return YES;
    }
    else if (self.object)
    {
        return [self.object respondsToSelector:aSelector];
    }
    else
    {
        return NO;
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //
    // Redirect message to original object and act the same as the original delegate
    //
    
    [self trackInvocation:anInvocation];
    
    if ([self.object respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:self.object];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature && self.object)
    {
        return [[self.object class] instanceMethodSignatureForSelector:aSelector];
    }
    
    return signature;
}

- (void)trackInvocation:(NSInvocation *)anInvocation
{
    //
    // Empty implementation does nothing
    //
}

@end
