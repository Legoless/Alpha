//
//  UIApplication+ALPHADelegate.m
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "UIApplication+ALPHADelegate.h"
#import "ALPHAApplicationDelegate.h"
#import "ALPHAManager.h"

@implementation UIApplication (ALPHADelegate)

+ (void)load
{
    //
    // Swizzle setDelegate method
    //
    
    [UIApplication swizzleInstanceMethod:@selector(setDelegate:) withMethod:@selector(alpha_setDelegate:)];
}

- (void)alpha_setDelegate:(id<UIApplicationDelegate>)delegate
{
    //
    // We will ensure the delegate of the UIApplication stays our own object
    //
    
    id targetDelegate = delegate;
    
    if (![targetDelegate isKindOfClass:[ALPHAApplicationDelegate class]])
    {
        //
        // Run Alpha integration just in case
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
        
        alphaDelegate = [self.delegate isKindOfClass:[ALPHAApplicationDelegate class]] ? self.delegate : [[ALPHAApplicationDelegate alloc] initWithDelegate:targetDelegate];
        
        alphaDelegate.object = targetDelegate;
        
        // Need to switch delegates here, to stay with Alpha delegate.
        targetDelegate = alphaDelegate;
    }
    
    [self alpha_setDelegate:targetDelegate];
}

@end
