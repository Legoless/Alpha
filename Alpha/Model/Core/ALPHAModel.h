//
//  ALPHAModel.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"
#import "ALPHAIdentifiableItem.h"

@interface ALPHAModel : NSObject <ALPHASerializableItem, ALPHAIdentifiableItem>

@property (nonatomic, copy) ALPHARequest* request;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (instancetype)initWithRequest:(ALPHARequest *)request;

@end
