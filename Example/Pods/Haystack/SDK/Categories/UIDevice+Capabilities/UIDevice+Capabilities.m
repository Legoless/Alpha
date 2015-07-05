//
//  UIDevice+Capabilities.m
//

#import "HAYMath.h"

#import "UIDevice+DeviceInfo.h"
#import "UIDevice+Capabilities.h"

@implementation UIDevice (Capabilities)

- (BOOL)hay_hasTouchID
{
    NSArray *touchIDModels = @[ @"iPhone6,1", @"iPhone6,2", @"iPhone7,1", @"iPhone7,2", @"iPad5,3", @"iPad5,4", @"iPad4,7", @"iPad4,8", @"iPad4,9" ];
    
    NSString *model = [self hay_modelIdentifier];
    
    return [touchIDModels containsObject:model];
}

- (BOOL)hay_hasRetina
{
    if ([[UIScreen mainScreen] scale] >= 2.0)
    {
        return YES;
    }
    
    return NO;
}

@end
