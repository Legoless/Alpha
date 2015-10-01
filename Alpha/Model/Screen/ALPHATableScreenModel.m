//
//  ALPHATableScreenModel.m
//  Alpha
//
//  Created by Dal Rupnik on 05/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableScreenModel.h"

@implementation ALPHATableScreenModel

- (instancetype)initWithRequest:(ALPHARequest *)request
{
    self = [super initWithRequest:request];
    
    if (self)
    {
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self;
}

@end
