//
//  ALPHAPropertyBox.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHAPropertyBox : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString* propertyName;
@property (nonatomic, copy) NSString* propertyType;

@property (nonatomic, copy) NSString* propertyValue;

@end
