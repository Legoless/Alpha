//
//  UIWindow+FLEXUtility.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "UIWindow+FLEXUtility.h"

@implementation UIWindow (FLEXUtility)

- (BOOL)isToolWindow
{
    NSString* class = NSStringFromClass([self class]);
    
    if ([class hasPrefix:@"FLEX"] || [class hasPrefix:@"ALPHA"])
    {
        return YES;
    }
    
    return NO;
}

@end
