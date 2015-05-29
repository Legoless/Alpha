//
//  FLEXMenuItem.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "ALPHAMenuActionItem.h"

@implementation ALPHAMenuActionItem

- (UIViewController *)viewControllerInstance
{
    Class viewControllerClass = NSClassFromString(self.viewControllerClass);
    
    if (viewControllerClass)
    {
        return [[viewControllerClass alloc] init];
    }
    
    return nil;
}

@end
