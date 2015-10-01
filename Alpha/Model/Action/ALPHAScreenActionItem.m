//
//  ALPHAScreenActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAScreenActionItem.h"

@implementation ALPHAScreenActionItem

- (void)setDataIdentifier:(NSString *)dataIdentifier
{
    self.request = [ALPHARequest requestWithIdentifier:dataIdentifier];
}

@end
