//
//  UIDevice+Status.m
//  UICatalog
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "UIDevice+Status.h"

@implementation UIDevice (Status)

- (NSString *)alpha_serviceProvider
{
    NSString* className = @"VVCarrierParameters";
    NSString* carrierSelector = @"carrierServiceName";
    
    Class class = NSClassFromString(className);
    
    id value = [class performSelector:NSSelectorFromString(carrierSelector)];
    
    if ([value isKindOfClass:[NSString class]])
    {
        return (NSString *)value;
    }
    
    return nil;
}

@end
