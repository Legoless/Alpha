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
 *  Action that opens a view controller should have this property set.
 */
@property (nonatomic, strong) NSString* viewControllerClass;

/*!
 *  Returns new view controller instance for selected class
 *
 *  @return instance
 */
- (UIViewController *)viewControllerInstance;

@end
