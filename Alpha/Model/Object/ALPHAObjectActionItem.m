//
//  ALPHAObjectActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectActionItem.h"

@implementation ALPHAObjectActionItem

- (instancetype)initWithObjectModel:(ALPHAObjectModel *)model
{
    if (!model)
    {
        return nil;
    }
    
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.action.object"];
    
    if (self)
    {
        self.objectPointer = model.objectPointer;
        self.objectClass = model.objectClass;
    }
    
    return self;
}

@end
