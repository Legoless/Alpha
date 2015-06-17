//
//  ALPHABonjourConnection.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "DTBonjourDataConnection.h"

@interface ALPHABonjourConnection : DTBonjourDataConnection

@property (nonatomic, weak) NSNetService* service;

@property (nonatomic, copy) NSString* id;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *system;
@property (nonatomic, copy) NSString *version;

@end
