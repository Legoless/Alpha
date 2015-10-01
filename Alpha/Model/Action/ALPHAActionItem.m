//
//  ALPHAActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAActionItem.h"

@implementation ALPHAActionItem

#pragma mark - Static Methods

+ (instancetype)itemWithIdentifier:(NSString *)identifier
{
    return [[[self class] alloc] initWithIdentifier:identifier title:nil detail:nil style:UITableViewCellStyleDefault];
}

#pragma mark - Initializers

- (instancetype)initWithRequest:(ALPHARequest *)request
{
    self = [super init];
    
    if (self)
    {
        self.request = request;
        self.enabled = YES;
        self.imageContentMode = UIViewContentModeCenter;
    }
    
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return [self initWithIdentifier:identifier title:nil detail:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier style:(UITableViewCellStyle)style;
{
    return [self initWithIdentifier:identifier title:nil detail:nil style:style];
}

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail
{
    return [self initWithIdentifier:identifier title:title detail:detail style:UITableViewCellStyleValue1];
}

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title detail:(NSString *)detail style:(UITableViewCellStyle)style
{
    ALPHARequest* request = [ALPHARequest requestWithIdentifier:identifier];
    
    ALPHAActionItem *object = [self initWithRequest:request];
    
    if (object)
    {
        object.title = title;
        object.detail = detail;
        object.style = style;
    }
    
    return object;
}

@end
