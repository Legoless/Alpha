//
//  UIDevice+ALPHAStatus.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "UIDevice+ALPHAStatus.h"

@implementation UIDevice (ALPHAStatus)

- (NSString *)alpha_carrierName
{
    NSString* className = @"VVCarrierParameters";
    NSString* carrierSelector = @"carrierServiceName";
    
    Class class = NSClassFromString(className);
    SEL selector = NSSelectorFromString(carrierSelector);
    
    if ([class respondsToSelector:selector])
    {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value = [class performSelector:selector];
        #pragma clang diagnostic pop
        
        if ([value isKindOfClass:[NSString class]])
        {
            return (NSString *)value;
        }
    }
    
    return nil;
}

@end
