//
//  FLEXPlugin.h
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXInformationCollector.h"

#import "FLEXActionItem.h"

@interface FLEXPlugin : NSObject

/*!
 *  Plugin identifier
 */
@property (nonatomic, readonly) NSString* identifier;

/*!
 *  Title of the FLEX plugin
 */
@property (nonatomic, readonly) NSString* title;

/*!
 *  Enables or disables the plugin
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Array of FLEXActionItem objects that plugin displays
 *  in the FLEX menu.
 */
@property (nonatomic, readonly) NSArray *actions;

/*!
 *  Array of FLEXInformationCollector objects that plugin initializes
 *  when started
 */
@property (nonatomic, readonly) NSArray *collectors;

/*!
 *  Main UIViewController of the plugin, it is linked to the Global Table
 *  and pushed on top of view controller stack.
 */
@property (nonatomic, readonly) UIViewController* mainInterface;

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
- (void)registerAction:(FLEXActionItem *)action;

/*!
 *  Designated initializer
 *
 *  @param identifier plugin identifier
 *
 *  @return instance of the plugin
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
