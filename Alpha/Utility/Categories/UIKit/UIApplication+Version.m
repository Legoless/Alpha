//
//  UIApplication+Version.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "UIApplication+Version.h"

@import UIKit;

@implementation UIApplication (Version)

- (NSString *)alpha_name {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)alpha_version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)alpha_build {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

- (NSString *)alpha_bundleIdentifier {
    return [NSBundle mainBundle].bundleIdentifier;
}

@end
