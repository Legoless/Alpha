//
//  ALPHAObjectArgument.h
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"
#import "ALPHAObjectPrintable.h"

@protocol ALPHAObjectArgument <NSObject>

@end

@interface ALPHAObjectArgument : NSObject <ALPHASerializableItem, ALPHAObjectPrintable>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) ALPHAObjectType *type;

@end
