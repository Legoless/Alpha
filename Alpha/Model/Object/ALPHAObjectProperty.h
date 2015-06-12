//
//  ALPHAObjectProperty.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectValue.h"

@protocol ALPHAObjectProperty <NSObject>

@end

@interface ALPHAObjectProperty : NSObject <ALPHASerializableItem>

@property (nonatomic, strong) ALPHAObjectType* type;
@property (nonatomic, strong) ALPHAObjectValue *value;

@end
