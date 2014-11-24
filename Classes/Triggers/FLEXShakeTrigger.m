//
//  FLEXShakeTrigger.m
//  UICatalog
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "UIApplication+FLEXEvent.h"

#import "FLEXShakeTrigger.h"

@interface FLEXShakeTrigger ()

@property (nonatomic, strong) NSDate* shakeDate;

@end

@implementation FLEXShakeTrigger

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shakeMotion:) name:FLEXShakeMotionNotification object:nil];
    }
    
    return self;
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
