//
//  ALPHAMenuItem.h
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

@interface ALPHAMenuActionItem : ALPHAActionItem

/*!
 *  Set to NO, if option should not appear in main menu
 */
@property (nonatomic, assign) BOOL isMain;

/*!
 *  Set to NO, if option is not available remotely
 */
@property (nonatomic, assign) BOOL isRemote;

/*!
 *  Action that opens a view controller should have this property set.
 */
@property (nonatomic, copy) NSString* viewControllerClass;

/*!
 *  Target data identifier that opens table sink view controller
 */
@property (nonatomic, copy) NSString* dataIdentifier;

/*!
 *  Returns new view controller instance for selected class, if viewControllerClass is set it will
 *  return a new instance of that view controller. If viewControllerClass is not set, but dataIdentifier
 *  is set, it will return view controller with data identifier.
 *
 *  @return instance
 */
- (UIViewController *)viewControllerInstance;

@end
