//
//  FLEXActionItem.m
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXActionItem.h"

@implementation FLEXActionItem

+ (instancetype)actionItemWithIdentifier:(NSString *)identifier
{
    return [[self alloc] initWithIdentifier:identifier];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    
    if (self)
    {
        self.identifier = identifier;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"FLEXActionItem: %@", self.identifier];
}

@end
