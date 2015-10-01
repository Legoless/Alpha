//
//  ALPHAScreenActionItem.h
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"
#import "ALPHADataSource.h"

@protocol ALPHAScreenActionItem <ALPHAActionItem>

@end

@interface ALPHAScreenActionItem : ALPHAActionItem

/*!
 *  Set to NO, if option should not appear in main menu
 */
@property (nonatomic, assign) BOOL isMain;

/*!
 *  Set to NO, if option is not available remotely
 */
@property (nonatomic, assign) BOOL isRemote;

/*!
 *  Action that opens a view controller should have this property set to class name.
 *  This is for backward support of view controller loading.
 */
@property (nonatomic, copy) NSString* viewControllerClass;

/*!
 *  Source pointer, to make it swap
 */
@property (nonatomic, strong) id<ALPHADataSource> source;

- (void)setDataIdentifier:(NSString *)dataIdentifier;

@end
