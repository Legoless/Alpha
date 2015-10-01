//
//  ALPHABlockActionItem.h
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

typedef id (^ALPHABlockActionItemAction)(id sender);

/*!
 *  Action that wraps a block of code to be executed. For use locally, cannot be transferred over network.
 */
@interface ALPHABlockActionItem : ALPHAActionItem

/*!
 *  Block to be executed on action
 */
@property (nonatomic, copy) ALPHABlockActionItemAction actionBlock;

@end
