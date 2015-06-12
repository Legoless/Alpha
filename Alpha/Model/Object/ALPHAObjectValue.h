//
//  ALPHAObjectValue.h
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"

@interface ALPHAObjectValue : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) id<ALPHASerializableItem> value;

@end
