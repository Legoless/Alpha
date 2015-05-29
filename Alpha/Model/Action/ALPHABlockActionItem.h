//
//  ALPHABlockActionItem.h
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

typedef void (^ALPHABlockActionItemAction)(id sender);

@interface ALPHABlockActionItem : ALPHAActionItem

/*!
 *  Block to be executed on action
 */
@property (nonatomic, copy) ALPHABlockActionItemAction actionBlock;

@end
