//
//  FLEXPluginManager.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "FLEXPlugin.h"

#import "FLEXPluginManager.h"

@interface FLEXPluginManager ()

@property (nonatomic, strong) NSMutableArray* basePlugins;

@end

@implementation FLEXPluginManager

#pragma mark - Singleton

+ (instancetype)sharedManager
{
    static FLEXPluginManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

#pragma mark - Getters and Setters

- (NSArray *)plugins
{
    //
    // Load plugins if they are not loaded yet
    //
    
    if (!self.basePlugins)
    {
        [self loadPlugins];
    }
    
    return [self.basePlugins copy];
}

#pragma mark - Helper methods

/**
 *  Generally this will only be called once, since plugins cannot be
 *  loaded at runtime. The concept here is that all plugins are loaded
 *  for the first time on start, even if the functionality is not
 *  available. They just appear inactive and dont use any resources,
 *  except for few kilobytes of data that keeps objcets in memory.
 *
 */
- (void)loadPlugins
{
    self.basePlugins = [NSMutableArray array];
    
    NSArray *pluginClasses = [FLEXPlugin subclasses];
    
    for (Class class in pluginClasses)
    {
        FLEXPlugin* plugin = [[class alloc] init];
        
        [self.basePlugins addObject:plugin];
    }
}

@end
