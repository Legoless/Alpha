//
//  UIApplication+Event.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sens. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "UIApplication+Event.h"

NSString* const ALPHAShakeMotionNotification = @"kALPHAShakeMotionNotification";
NSString* const ALPHAInterfaceEventNotification = @"kALPHAInterfaceEventNotification";

@implementation UIApplication (Event)

+ (void)load
{
    [UIApplication hay_swizzleInstanceMethod:@selector(sendEvent:) withMethod:@selector(alpha_sendEvent:)];
}

- (void)alpha_sendEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAShakeMotionNotification object:event];
    }
    
    //
    // Send notification of event
    //
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALPHAInterfaceEventNotification object:event];
    
    [self alpha_sendEvent:event];
}

@end
