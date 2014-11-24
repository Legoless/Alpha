//
//  FLEXPlugin.h
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXInformationCollector.h"

@interface FLEXPlugin : NSObject

/**
 *  Title of the FLEX plugin
 */
@property (nonatomic, readonly) NSString* title;

/**
 *  Enables or disables the plugin
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/**
 *  Array of FLEXActionItem objects that plugin displays
 *  in the FLEX menu.
 */
@property (nonatomic, readonly) NSArray *actions;

/**
 *  Array of FLEXInformationCollector objects that plugin initializes
 *  when started
 */
@property (nonatomic, readonly) NSArray *collectors;

/**
 *  Main UIViewController of the plugin, it is linked to the Global Table
 *  and pushed on top of view controller stack.
 */
@property (nonatomic, readonly) UIViewController* mainInterface;

@end
