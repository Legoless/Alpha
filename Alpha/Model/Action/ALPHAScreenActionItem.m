//
//  ALPHAScreenActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAScreenActionItem.h"
#import "ALPHADataRenderer.h"
#import "ALPHATableRendererViewController.h"

@implementation ALPHAScreenActionItem

- (void)setDataIdentifier:(NSString *)dataIdentifier
{
    self.request = [ALPHARequest requestWithIdentifier:dataIdentifier];
}

@end
