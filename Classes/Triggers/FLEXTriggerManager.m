//
//  FLEXTriggerManager.m
//  UICatalog
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "FLEXNetworkInformationCollector.h"

#import "FLEXTapTrigger.h"
#import "FLEXShakeTrigger.h"

#import "FLEXInformationManager.h"

#import "FLEXTriggerManager.h"

@interface FLEXTriggerManager ()

@property (nonatomic, strong) NSMutableSet *baseTriggers;

@end

@implementation FLEXTriggerManager

#pragma mark - Getters and Setters

+ (instancetype)sharedManager
{
    static FLEXTriggerManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (NSArray *)triggers
{
    return [self.baseTriggers copy];
}

- (NSMutableSet *)baseTriggers
{
    if (!_baseTriggers)
    {
        _baseTriggers = [NSMutableSet set];
    }
    
    return _baseTriggers;
}

#pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

#pragma mark - Methods

+ (void)load
{
    //
    // Sign to a notification
    //
    
    [[NSNotificationCenter defaultCenter] addObserver:[FLEXTriggerManager sharedManager] selector:@selector(activate) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

- (void)addTrigger:(FLEXTrigger *)trigger
{
    [self.baseTriggers addObject:trigger];
    
    //
    // Integrate trigger
    //
    
    [trigger integrate];
}

/**
 *  This is called when application finishes launching
 */
- (void)activate
{
    //
    // Check for testing target, not activating anything in that
    // case, so we do not use any resources.
    //
    
    if ([[UIApplication sharedApplication] isRunningTests])
    {
        return;
    }
    
    //
    // Activate triggers
    //
    
    [self addTrigger:[[FLEXShakeTrigger alloc] init]];
    [self addTrigger:[[FLEXTapTrigger alloc] init]];
    
    //
    // Activate information manager
    //
    
    [[FLEXInformationManager sharedManager] setupCollectors];
    
    [FLEXNetworkInformationCollector injectIntoAllNSURLConnectionDelegateClasses];
    
    for (FLEXInformationCollector *collector in [FLEXInformationManager sharedManager].collectors)
    {
        [collector activate];
    }
    
}

@end
