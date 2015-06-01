//
//  ALPHAMenuActionItem.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMenuActionItem.h"
#import "ALPHADataSink.h"

@implementation ALPHAMenuActionItem

- (UIViewController *)viewControllerInstance
{
    NSString *viewControllerClassString = self.viewControllerClass;
    
    if (!viewControllerClassString && self.dataIdentifier)
    {
        viewControllerClassString = @"ALPHATableSinkViewController";
    }
    
    if (viewControllerClassString)
    {
        Class viewControllerClass = NSClassFromString(viewControllerClassString);

        if (viewControllerClass)
        {
            id viewController = [[viewControllerClass alloc] init];
            
            if ([viewController conformsToProtocol:@protocol(ALPHADataSink)] && self.dataIdentifier)
            {
                [viewController setDataIdentifier:self.dataIdentifier];
            }
            
            return viewController;
        }
    }
    
    return nil;
}

@end
