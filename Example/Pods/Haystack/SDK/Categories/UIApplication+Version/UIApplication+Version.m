//
//  UIApplication+Version.m
//

@import UIKit;

@implementation UIApplication (Version)

- (NSString *)hay_name
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)hay_version
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)hay_build
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

- (NSString *)hay_bundleIdentifier
{
    return [NSBundle mainBundle].bundleIdentifier;
}

@end