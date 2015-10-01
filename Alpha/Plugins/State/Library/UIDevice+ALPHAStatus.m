//
//  UIDevice+ALPHAStatus.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIApplication+Private.h"
#import "UIDevice+ALPHAStatus.h"

@implementation UIDevice (ALPHAStatus)

/*
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
    
    return @"Unavailable";
}*/

- (NSString *)alpha_carrierName
{
    UIView* statusBar = [[UIApplication sharedApplication] alpha_statusBar];
    
    UIView* statusBarForegroundView = nil;
    
    for (UIView* view in statusBar.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"UIStatusBarForegroundView")])
        {
            statusBarForegroundView = view;
            break;
        }
    }
    
    UIView* statusBarServiceItem = nil;
    
    for (UIView* view in statusBarForegroundView.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"UIStatusBarServiceItemView")])
        {
            statusBarServiceItem = view;
            break;
        }
    }
    
    if (statusBarServiceItem)
    {
        id value = [statusBarServiceItem valueForKey:@"_serviceString"];
        
        if ([value isKindOfClass:[NSString class]])
        {
            return (NSString *)value;
        }
    }
    
    return @"Unavailable";
}

@end
