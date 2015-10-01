//
//  ALPHASelectorActionItem.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

@protocol ALPHASelectorActionItem <ALPHAActionItem>

@end

@interface ALPHASelectorActionItem : ALPHAActionItem

@property (nonatomic, copy) NSString* selector;

@end
