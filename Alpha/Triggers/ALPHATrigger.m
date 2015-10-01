//
//  ALPHATrigger.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAManager.h"
#import "ALPHATrigger.h"

@implementation ALPHATrigger

@synthesize enabled = _enabled;

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.enabled = YES;
    }
    
    return self;
}

- (void)trigger:(id)sender
{
    if (self.enabled)
    {
        [[ALPHAManager defaultManager] setInterfaceHidden:NO];
    }
}

@end
