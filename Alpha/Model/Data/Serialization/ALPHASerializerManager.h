//
//  ALPHASerializerManager.h
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializer.h"

@interface ALPHASerializerManager : NSObject <ALPHASerializer>

@property (nonatomic, strong) id<ALPHASerializer> serializer;

+ (instancetype)sharedManager;

@end
