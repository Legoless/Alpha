//
//  ALPHAObjectIvar.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"
#import "ALPHAObjectElement.h"

@protocol ALPHAObjectIvar <NSObject>

@end

@interface ALPHAObjectIvar : ALPHAObjectElement <ALPHAObjectPrintable>

@property (nonatomic, strong) ALPHAObjectType* type;
@property (nonatomic, strong) id value;

@end
