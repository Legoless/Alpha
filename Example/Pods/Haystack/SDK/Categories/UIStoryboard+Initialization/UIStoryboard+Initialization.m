//
//  UIStoryboard+Initialization.m
//

#import "UIStoryboard+Initialization.h"

@implementation UIStoryboard (Convenience)

+ (UIViewController *)hay_initialViewControllerInStoryboardWithName:(NSString *)name
{
    UIStoryboard *storyboard = [self storyboardWithName:name bundle:nil];
    
    return [storyboard instantiateInitialViewController];
}

@end
