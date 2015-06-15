//
//  ALPHAObjectIvar.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"

@protocol ALPHAObjectIvar <NSObject>

@end

@interface ALPHAObjectIvar : NSObject <ALPHASerializableItem, ALPHAObjectPrintable>

//
// References to original object
//
@property (nonatomic, copy) NSString* objectClass;
@property (nonatomic, copy) NSString* objectPointer;

//
// Ivar info
//

@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong) ALPHAObjectType* type;
@property (nonatomic, strong) NSString *value;

@end
