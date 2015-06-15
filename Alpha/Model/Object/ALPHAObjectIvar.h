//
//  ALPHAObjectIvar.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"
#import "ALPHAObjectReference.h"

@protocol ALPHAObjectIvar <NSObject>

@end

@interface ALPHAObjectIvar : ALPHAObjectReference <ALPHAObjectPrintable>

//
// Ivar info
//

@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong) ALPHAObjectType* type;
@property (nonatomic, strong) NSString *value;

- (id)convertedValue;

@end
