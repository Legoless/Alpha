//
//  ALPHAObjectPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectSource.h"

#import "ALPHAObjectPlugin.h"

@implementation ALPHAObjectPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.object"];
    
    if (self)
    {
        //
        // Object plugin has no specific menu actions
        //
        
        [self registerSource:[ALPHAObjectSource new]];
    }
    
    return self;
}

@end
