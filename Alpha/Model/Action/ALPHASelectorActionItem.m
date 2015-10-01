//
//  ALPHASelectorActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASelectorActionItem.h"

@implementation ALPHASelectorActionItem

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: Sel: %@", [super description], self.selector];
}

@end
