//
//  ALPHABonjourConnection.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHABonjourConnection.h"

@implementation ALPHABonjourConnection

- (id)initWithService:(NSNetService *)service
{
    self = [super initWithService:service];
    
    if (self)
    {
        self.service = service;
        
        NSDictionary *dict = [NSNetService dictionaryFromTXTRecordData:service.TXTRecordData];
        
        self.name = [[NSString alloc] initWithData:dict[@"name"] encoding:NSUTF8StringEncoding];
        self.type = [[NSString alloc] initWithData:dict[@"type"] encoding:NSUTF8StringEncoding];
        self.system = [[NSString alloc] initWithData:dict[@"system"] encoding:NSUTF8StringEncoding];
        self.version = [[NSString alloc] initWithData:dict[@"version"] encoding:NSUTF8StringEncoding];
    }
    
    return self;
}

@end
