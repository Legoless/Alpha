//
//  UIViewController+ALPHAEventLog.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "NSObject+Swizzle.h"

#import "NSString+Identifier.h"

#import "UIViewController+ALPHAEventLog.h"
#import "ALPHAEventSource.h"

@implementation UIViewController (ALPHAEventLog)

+ (void)load
{
    [UIViewController alpha_swizzleInstanceMethod:@selector(viewDidAppear:) withMethod:@selector(alpha_viewDidAppear:)];
    [UIViewController alpha_swizzleInstanceMethod:@selector(viewDidDisappear:) withMethod:@selector(alpha_viewDidDisappear:)];
}

- (void)alpha_viewDidAppear:(BOOL)animated
{
    ALPHAApplicationEvent *event = [[ALPHAApplicationEvent alloc] init];
    event.name = [NSString stringWithFormat:@"Appear %@", [NSStringFromClass(self.class) alpha_cleanCodeIdentifier]];
    event.sender = NSStringFromClass(self.class);
    event.info = @{ @"animated" : @(animated) };

    if (![event.sender hasPrefix:@"ALPHA"])
    {
        [[ALPHAEventSource sharedSource] addEvent:event];
    }
    
    [self alpha_viewDidAppear:animated];
}

- (void)alpha_viewDidDisappear:(BOOL)animated
{
    ALPHAApplicationEvent *event = [[ALPHAApplicationEvent alloc] init];
    event.name = [NSString stringWithFormat:@"Disappear %@", [NSStringFromClass(self.class) alpha_cleanCodeIdentifier]];
    event.sender = NSStringFromClass(self.class);
    event.info = @{ @"animated" : @(animated) };

    if (![event.sender hasPrefix:@"ALPHA"])
    {
        [[ALPHAEventSource sharedSource] addEvent:event];
    }
    
    [self alpha_viewDidDisappear:animated];
}


@end
