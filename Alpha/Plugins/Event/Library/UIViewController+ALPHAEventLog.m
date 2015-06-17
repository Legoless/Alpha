//
//  UIViewController+ALPHAEventLog.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "NSString+Identifier.h"

#import "UIViewController+ALPHAEventLog.h"
#import "ALPHAEventCollector.h"

@implementation UIViewController (ALPHAEventLog)

+ (void)load
{
    [UIViewController swizzleInstanceMethod:@selector(viewDidAppear:) withMethod:@selector(alpha_viewDidAppear:)];
    [UIViewController swizzleInstanceMethod:@selector(viewDidDisappear:) withMethod:@selector(alpha_viewDidDisappear:)];
}

- (void)alpha_viewDidAppear:(BOOL)animated
{
    ALPHAApplicationEvent *event = [[ALPHAApplicationEvent alloc] init];
    event.name = [NSString stringWithFormat:@"Appear %@", [NSStringFromClass(self.class) alpha_cleanCodeIdentifier]];
    event.sender = NSStringFromClass(self.class);
    event.info = @{ @"animated" : @(animated) };
    
    // TODO: Remove FLEX backwards support when ready
    if (![event.sender startsWith:@"ALPHA"] && ![event.sender startsWith:@"FLEX"])
    {
        [[ALPHAEventCollector sharedCollector] addEvent:event];
    }
    
    [self alpha_viewDidAppear:animated];
}

- (void)alpha_viewDidDisappear:(BOOL)animated
{
    ALPHAApplicationEvent *event = [[ALPHAApplicationEvent alloc] init];
    event.name = [NSString stringWithFormat:@"Disappear %@", [NSStringFromClass(self.class) alpha_cleanCodeIdentifier]];
    event.sender = NSStringFromClass(self.class);
    event.info = @{ @"animated" : @(animated) };
    
    // TODO: Remove FLEX backwards support when ready
    if (![event.sender startsWith:@"ALPHA"] && ![event.sender startsWith:@"FLEX"])
    {
        [[ALPHAEventCollector sharedCollector] addEvent:event];
    }
    
    [self alpha_viewDidDisappear:animated];
}


@end
