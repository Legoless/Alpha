//
//  UIApplication+Delegate.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "NSObject+Swizzle.h"

#import "UIApplication+Delegate.h"
#import "ALPHAApplicationDelegate.h"
#import "ALPHAManager.h"

@implementation UIApplication (Delegate)

+ (void)load
{
    //
    // Swizzle delegate methods, to hide Alpha's delegation injection
    //
    
    [UIApplication alpha_swizzleInstanceMethod:@selector(setDelegate:) withMethod:@selector(alpha_setDelegate:)];
}

- (id)alpha_injectedDelegate
{
    return objc_getAssociatedObject(self, @selector(alpha_injectedDelegate));
}

- (void)setAlpha_injectedDelegate:(id)alpha_injectedDelegate
{
    objc_setAssociatedObject(self, @selector(alpha_injectedDelegate), alpha_injectedDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

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
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            [[ALPHAManager defaultManager] integrate];
        //});
        
        //
        // Target delegate is not Alpha delegate, we check if we already have it set (maybe someone else wants to change the delegate class). In that case we will set it as Alpha's delegate
        //
        // Mark it as static, so it is not released too early.
        //
        
        static ALPHAApplicationDelegate* alphaDelegate;
        
        alphaDelegate = [self.alpha_injectedDelegate isKindOfClass:[ALPHAApplicationDelegate class]] ? self.alpha_injectedDelegate : [[ALPHAApplicationDelegate alloc] initWithDelegate:targetDelegate];
        
        alphaDelegate.object = targetDelegate;
        
        self.alpha_injectedDelegate = alphaDelegate;
        
        // Need to switch delegates here, to stay with Alpha delegate.
        targetDelegate = alphaDelegate;
    }
    
    [self alpha_setDelegate:targetDelegate];
}

@end
