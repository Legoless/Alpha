//
//  FLEXInformationCollector.m
//  UICatalog
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "FLEXInformationCollector.h"

@implementation FLEXInformationCollector

+ (instancetype)sharedCollector;
{
    static NSMutableDictionary* defaultInstances = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultInstances = [[NSMutableDictionary alloc] init];
    });
    
    if (!defaultInstances[NSStringFromClass(self.class)])
    {
        defaultInstances[NSStringFromClass(self.class)] = [[self.class alloc] init];
    }
    
    return defaultInstances[NSStringFromClass(self.class)];
}


+ (NSArray *)informationCollectors
{
    return [FLEXInformationCollector subclasses];
}

- (void)activate
{

}

@end
