//
//  FLEXPluginManager.h
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXBasePlugin.h"
#import "FLEXPlugin.h"

@interface FLEXPluginManager : NSObject

/**
 *  Loaded plugins in FLEX
 */
@property (nonatomic, readonly) NSArray *plugins;

/**
 *  Always allocated because it manages entire FLEX functionality
 */
@property (nonatomic, readonly) FLEXBasePlugin* basePlugin;

+ (instancetype)sharedManager;

/**
 *  Returns plugin instance of class
 *
 *  @param class plugin class
 *
 *  @return plugin instance
 */
- (FLEXPlugin *)enabledPluginOfClass:(Class)class;

@end
