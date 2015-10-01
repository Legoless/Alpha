//
//  ALPHAScreenRenderableItem.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenItem.h"

@protocol ALPHAScreenRenderableItem <NSObject>

/*!
 *  Returns screen item from model
 *
 *  @return screen item
 */
- (ALPHAScreenItem *)screenItem;

@end