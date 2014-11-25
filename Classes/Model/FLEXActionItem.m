//
//  FLEXActionItem.m
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXActionItem.h"

@implementation FLEXActionItem

#pragma mark - Getters and Setters

- (void)setIcon:(id)icon
{
    if ([icon isKindOfClass:[UIImage class]] || [icon isKindOfClass:[NSString class]])
    {
        _icon = icon;
    }
    else
    {
        @throw [NSException exceptionWithName:@"Icon can be a string or UIImage" reason:@"Only NSString and UIImage is supported for icon." userInfo:@{ @"icon" : icon }];
    }
}

#pragma mark - Static Methods

+ (instancetype)itemWithIdentifier:(NSString *)identifier
{
    return [[self alloc] initWithIdentifier:identifier];
}

#pragma mark - Initializers

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Action needs an identifier" reason:@"No identifier specified" userInfo:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    
    if (self)
    {
        self.identifier = identifier;
        self.enabled = YES;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"FLEXActionItem: %@", self.identifier];
}

@end
