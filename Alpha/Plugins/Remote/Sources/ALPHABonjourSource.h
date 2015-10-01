//
//  ALPHABonjourSource.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"
#import "ALPHABonjourConnection.h"

@interface ALPHABonjourSource : NSObject <ALPHADataSource>

@property (nonatomic, strong) ALPHABonjourConnection *connection;

- (instancetype)initWithConnection:(ALPHABonjourConnection *)connection;

@end
