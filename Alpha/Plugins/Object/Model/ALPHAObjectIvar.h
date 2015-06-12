//
//  ALPHAObjectIvar.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHAObjectIvar : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString* ivarName;
@property (nonatomic, copy) NSString* ivarType;

@property (nonatomic, copy) NSString* ivarValue;

@end
