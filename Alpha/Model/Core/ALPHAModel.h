//
//  ALPHAModel.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"
#import "ALPHAIdentifiableItem.h"

@interface ALPHAModel : NSObject <ALPHASerializableItem, ALPHAIdentifiableItem>

@property (nonatomic, copy) ALPHARequest* request;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (instancetype)initWithRequest:(ALPHARequest *)request;

@end
