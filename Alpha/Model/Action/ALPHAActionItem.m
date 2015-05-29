//
//  ALPHAActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

@implementation ALPHAActionItem

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail style:(UITableViewCellStyle)style
{
    self = [super initWithIdentifier:identifier title:title detail:detail style:style];
    
    if (self)
    {
        self.enabled = YES;
    }
    
    return self;
}

@end
