//
//  FLEXEventEngine.m
//  UICatalog
//
//  Created by Dal Rupnik on 16/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXEventEngine.h"

@implementation FLEXEventEngine

+ (instancetype)sharedEngine
{
    static FLEXEventEngine *sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEngine = [[[self class] alloc] init];
    });
    return sharedEngine;
}

@end
