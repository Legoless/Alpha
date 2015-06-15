//
//  ALPHAObjectReference.h
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHAObjectReference : NSObject <ALPHASerializableItem>

//
// References to original object
//
@property (nonatomic, copy) NSString* objectClass;
@property (nonatomic, copy) NSString* objectPointer;


@end
