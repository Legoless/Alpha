//
//  ALPHAPlugin.h
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHABaseDataSource.h"

#import "ALPHAActionItem.h"

@interface ALPHAPlugin : NSObject

/*!
 *  Plugin identifier
 */
@property (nonatomic, readonly) NSString* identifier;

/*!
 *  Title of the plugin
 */
@property (nonatomic, readonly) NSString* title;

/*!
 *  Enables or disables the plugin
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Array of action item objects that plugin displays
 *  in the explorer menu or main diagnostic menu.
 */
@property (nonatomic, readonly) NSArray *actions;

/*!
 *  Array of data source objects that plugin initializes when loaded.
 *  Objects in array conform to protocol ALPHADataSource.
 */
@property (nonatomic, readonly) NSArray *sources;

/*!
 *  Main UIViewController of the plugin, it is linked to the Global Table
 *  and pushed on top of view controller stack.
 */
@property (nonatomic, readonly) UIViewController* mainInterface;

/*!
 *  Designated initializer
 *
 *  @param identifier plugin identifier
 *
 *  @return instance of the plugin
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;

/*!
 *  If returned YES, the view controller will take control of the touch.
 *
 *  @param pointInWindow point in window
 *
 *  @return YES if plugin will handle the touch.
 */
- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow;

/*!
 *  Adds and registers action for plugin
 *
 *  @param action to register
 */
- (void)registerAction:(ALPHAActionItem *)action;

/*!
 *  Registers data collector source to plugin.
 *
 *  @param source data
 */
- (void)registerSource:(id<ALPHADataSource>)source;

@end
