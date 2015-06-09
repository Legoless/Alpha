//
//  ALPHAMenuActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMenuActionItem.h"
#import "ALPHADataRenderer.h"
#import "ALPHATableDataRendererViewController.h"

@implementation ALPHAMenuActionItem

- (UIViewController *)viewControllerInstance
{
    NSString *viewControllerClassString = self.viewControllerClass;
    
    if (!viewControllerClassString && self.dataIdentifier)
    {
        viewControllerClassString = NSStringFromClass([ALPHATableDataRendererViewController class]);
    }
    
    if (viewControllerClassString)
    {
        Class viewControllerClass = NSClassFromString(viewControllerClassString);

        if (viewControllerClass)
        {
            id viewController = [[viewControllerClass alloc] init];
            
            if ([viewController respondsToSelector:@selector(setRequest:)] && self.dataIdentifier)
            {
                [viewController setRequest:[ALPHARequest requestWithIdentifier:self.dataIdentifier]];
            }
            
            return viewController;
        }
    }
    
    return nil;
}

@end
