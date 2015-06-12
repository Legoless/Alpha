//
//  ALPHAObjectArgument.h
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"

@protocol ALPHAObjectArgument <NSObject>

@end

@interface ALPHAObjectArgument : NSObject <ALPHASerializableItem>

@property (nonatomic, strong) ALPHAObjectType *type;
@property (nonatomic, copy) NSString *name;

@end
