//
//  ALPHAHeapPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"

#import "ALPHAHeapPlugin.h"
#import "ALPHAHeapSource.h"

@implementation ALPHAHeapPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.heap"];
    
    if (self)
    {
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.memoryHeap"];
        menuAction.icon = @"💩";
        menuAction.title = @"Heap Objects";
        menuAction.dataIdentifier = ALPHAHeapDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHAHeapSource new]];
    }
    
    return self;
}

@end
