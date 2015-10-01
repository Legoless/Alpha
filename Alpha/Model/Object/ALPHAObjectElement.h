//
//  ALPHAObjectElement.h
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@protocol ALPHAObjectElement <NSObject>

@end

@interface ALPHAObjectElement : NSObject <ALPHASerializableItem>

//
// References to original object
//
@property (nonatomic, copy) NSString* objectClass;
@property (nonatomic, copy) NSString* objectPointer;

@property (nonatomic, copy) NSString *name;

@end
