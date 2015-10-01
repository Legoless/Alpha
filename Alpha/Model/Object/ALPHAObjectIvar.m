//
//  ALPHAObjectIvar.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"

#import "ALPHAObjectIvar.h"

@implementation ALPHAObjectIvar

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.type = [ALPHAObjectType new];
    }
    
    return self;
}

- (NSString *)prettyDescription
{
    return [ALPHARuntimeUtility appendName:self.name toType:self.type.name];
}

@end
