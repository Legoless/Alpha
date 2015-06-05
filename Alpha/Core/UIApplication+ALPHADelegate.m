//
//  UIApplication+ALPHADelegate.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>
#import <objc/runtime.h>

#import "UIApplication+ALPHADelegate.h"
#import "ALPHAApplicationDelegate.h"
#import "ALPHAManager.h"

@implementation UIApplication (ALPHADelegate)

+ (void)load
{
    //
    // Swizzle delegate methods, to hide Alpha's delegation injection
    //
    
    [UIApplication swizzleInstanceMethod:@selector(setDelegate:) withMethod:@selector(alpha_setDelegate:)];
    //[UIApplication swizzleInstanceMethod:@selector(delegate) withMethod:@selector(alpha_delegate)];
}

- (id)injectedDelegate
{
    return objc_getAssociatedObject(self, @selector(injectedDelegate));
}

- (void)setInjectedDelegate:(id)injectedDelegate
{
    objc_setAssociatedObject(self, @selector(injectedDelegate), injectedDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
- (id<UIApplicationDelegate>)alpha_delegate
{
    id<UIApplicationDelegate> delegate = [self alpha_delegate];
    
    if ([delegate isKindOfClass:[ALPHAApplicationDelegate class]])
    {
        ALPHAApplicationDelegate* alphaDelegate = delegate;
        
        return alphaDelegate.object;
    }
    else
    {
        return delegate;
    }
}*/

- (void)alpha_setDelegate:(id<UIApplicationDelegate>)delegate
{
    id targetDelegate = delegate;
    
    //
    // We will ensure the delegate of the UIApplication stays our own object,
    // regardless of what is set
    //
    
    if (![targetDelegate isKindOfClass:[ALPHAApplicationDelegate class]])
    {
        //
        // Run Alpha integration, only integrates once anyway
        //
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ALPHAManager sharedManager] integrate];
        });
        
        //
        // Target delegate is not Alpha delegate, we check if we already have it set (maybe someone else wants to change the delegate class). In that case we will set it as Alpha's delegate
        //
        // Mark it as static, so it is not released too early.
        //
        
        static ALPHAApplicationDelegate* alphaDelegate;
        
        alphaDelegate = [self.injectedDelegate isKindOfClass:[ALPHAApplicationDelegate class]] ? self.injectedDelegate : [[ALPHAApplicationDelegate alloc] initWithDelegate:targetDelegate];
        
        alphaDelegate.object = targetDelegate;
        
        self.injectedDelegate = alphaDelegate;
        
        // Need to switch delegates here, to stay with Alpha delegate.
        targetDelegate = alphaDelegate;
    }
    
    [self alpha_setDelegate:targetDelegate];
}

@end
