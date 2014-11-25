//
//  UIApplication+FLEXEvent.m
//  UICatalog
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "UIApplication+FLEXEvent.h"

NSString* const FLEXShakeMotionNotification = @"kFLEXShakeMotionNotification";
NSString* const FLEXInterfaceEventNotification = @"kFLEXInterfaceEventNotification";

@implementation UIApplication (FLEXEvent)

+ (void)load
{
    [UIApplication swizzleInstanceMethod:@selector(sendEvent:) withMethod:@selector(flex_sendEvent:)];
}

- (void)flex_sendEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake )
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:FLEXShakeMotionNotification object:nil];
    }
    
    //
    // Send notification of event
    //
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FLEXInterfaceEventNotification object:event];
    
    [self flex_sendEvent:event];
}

@end
