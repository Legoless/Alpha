//
//  ALPHAModel.m
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHASerialization.h"

@implementation ALPHAModel

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init
{
    return [self initWithRequest:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    ALPHARequest* request = [ALPHARequest requestWithIdentifier:identifier];
    
    return [self initWithRequest:request];
}

- (instancetype)initWithRequest:(ALPHARequest *)request
{
    self = [super init];
    
    if (self)
    {
        self.request = request;
    }
    
    return self;
}

@end
