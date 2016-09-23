//
//  ALPHAApplicationEvent.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationEvent.h"
#import "ALPHASerialization.h"

@implementation ALPHAApplicationEvent

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.date = [NSDate date];
    }
    
    return self;
}

@end
