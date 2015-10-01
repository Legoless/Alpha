//
//  ALPHAIdentifiableItem.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARequest.h"

@protocol ALPHASerializableItem;

@protocol ALPHAIdentifiableItem <ALPHASerializableItem>

@property (nonatomic, copy) ALPHARequest *request;

- (instancetype)initWithRequest:(ALPHARequest *)request;

@end
