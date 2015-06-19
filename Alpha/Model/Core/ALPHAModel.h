//
//  ALPHAModel.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataRenderer.h"
#import "ALPHADataSource.h"
#import "ALPHASerialization.h"
#import "ALPHAIdentifiableItem.h"
#import "ALPHAPlugin.h"

@interface ALPHAModel : NSObject <ALPHASerializableItem, ALPHAIdentifiableItem>

@property (nonatomic, copy) ALPHARequest* request;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (instancetype)initWithRequest:(ALPHARequest *)request;

@end
