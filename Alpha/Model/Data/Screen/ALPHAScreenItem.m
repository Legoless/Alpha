//
//  ALPHAScreenItem.m
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenItem.h"

NSString* const ALPHADisplayItemTitleKey = @"kALPHADisplayItemTitleKey";
NSString* const ALPHADisplayItemDetailkey = @"kALPHADisplayItemDetailkey";

@implementation ALPHAScreenItem

#pragma mark - Getters and Setters

- (void)setTitle:(id)title
{
    _title = title;
    
    if ([title isKindOfClass:[NSString class]])
    {
        self.titleText = title;
    }
    else if ([title isKindOfClass:[NSAttributedString class]])
    {
        self.attributedTitleText = title;
    }
}

- (void)setIcon:(id)icon
{
    if ([icon isKindOfClass:[UIImage class]] || [icon isKindOfClass:[NSString class]] || !icon)
    {
        _icon = icon;
    }
    else
    {
        @throw [NSException exceptionWithName:@"Icon can be a string or UIImage" reason:@"Only NSString and UIImage is supported for icon." userInfo:@{ @"icon" : icon }];
    }
}

@end
