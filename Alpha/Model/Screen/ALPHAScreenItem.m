//
//  ALPHAScreenItem.m
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenItem.h"
#import "ALPHASerialization.h"

NSString* const ALPHADisplayItemTitleKey = @"kALPHADisplayItemTitleKey";
NSString* const ALPHADisplayItemDetailkey = @"kALPHADisplayItemDetailkey";

@implementation ALPHAScreenItem

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - Getters and Setters

- (NSString *)title
{
    if (self.titleText)
    {
        return self.titleText;
    }
    else if (self.attributedTitleText)
    {
        return self.attributedTitleText.string;
    }
    
    return nil;
}

- (void)setTitle:(id)title
{
    if ([title isKindOfClass:[NSString class]])
    {
        self.titleText = title;
    }
    else if ([title isKindOfClass:[NSAttributedString class]])
    {
        self.attributedTitleText = title;
    }
}

- (NSString *)detail
{
    if (self.detailText)
    {
        return self.detailText;
    }
    else if (self.attributedDetailText)
    {
        return self.attributedDetailText.string;
    }
    
    return nil;
}

- (void)setDetail:(id)detail
{
    if ([detail isKindOfClass:[NSString class]])
    {
        self.detailText = detail;
    }
    else if ([detail isKindOfClass:[NSAttributedString class]])
    {
        self.attributedDetailText = detail;
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

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.imageContentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

@end
