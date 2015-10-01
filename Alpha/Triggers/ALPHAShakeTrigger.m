//
//  ALPHAShakeTrigger.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "UIApplication+Event.h"

#import "ALPHAShakeTrigger.h"

@interface ALPHAShakeTrigger ()

@property (nonatomic, strong) NSDate* shakeDate;

@end

@implementation ALPHAShakeTrigger

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (enabled)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shakeMotion:) name:ALPHAShakeMotionNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)shakeMotion:(id)sender
{
    if (self.shakeDate && fabs([self.shakeDate timeIntervalSinceNow]) > 1.0 && fabs([self.shakeDate timeIntervalSinceNow]) < 5.0)
    {
        [self trigger:sender];
        
        self.shakeDate = nil;
    }
    else if (!self.shakeDate || fabs([self.shakeDate timeIntervalSinceNow]) > 5.0)
    {
        self.shakeDate = [NSDate date];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
