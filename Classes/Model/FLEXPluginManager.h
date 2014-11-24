//
//  FLEXPluginManager.h
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@interface FLEXPluginManager : NSObject

/**
 *  Loaded plugins in FLEX
 */
@property (nonatomic, readonly) NSArray *plugins;

+ (instancetype)sharedManager;

@end
