 //
//  ALPHAObjectActionItem.h
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

#import "ALPHAObjectModel.h"

/*!
 *  Object action can be executed on any object
 */
@interface ALPHAObjectActionItem : ALPHAActionItem

/*!
 *  Object pointer on which to execute action
 */
@property (nonatomic, copy) NSString* objectPointer;

/*!
 *  Object class on which to execute action
 */
@property (nonatomic, copy) NSString *objectClass;

/*!
 *  Selector to execute on specific object (property setter or method call)
 */
@property (nonatomic, copy) NSString* selector;

/*!
 *  iVar to edit on specific object
 */
@property (nonatomic, copy) NSString* ivar;

@property (nonatomic, copy) NSArray *arguments;

@end
