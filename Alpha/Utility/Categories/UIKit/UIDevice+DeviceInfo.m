//
//  UIDevice+DeviceInfo.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "UIDevice+DeviceInfo.h"

#include <Endian.h>

#import "UIDevice+DeviceInfo.h"
#import "ALPHAMath.h"

int	sysctlbyname(const char *, void *, size_t *, void *, size_t);

@implementation UIDevice (DeviceInfo)

- (BOOL)alpha_isWidescreen
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
#ifdef __IPHONE_8_0
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]) {
        bounds = [[UIScreen mainScreen] nativeBounds];
    }
    
#endif
    
    NSInteger gcd = [ALPHAMath greatestCommonDivisorForA:(NSInteger) bounds.size.width b:(NSInteger) bounds.size.height];
    
    double larger = fmax (bounds.size.width, bounds.size.height);
    double smaller = fmin (bounds.size.width, bounds.size.height);
    
    return !(( (larger / gcd == 3) && (smaller / gcd == 2) ) || ( (larger / gcd == 4) && (smaller / gcd == 3) ));
}


- (BOOL)alpha_isiPhone {
    if ([self.model isEqualToString:@"iPhone"] && [self userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    
    return NO;
}

- (BOOL)alpha_isiPod {
    if ([self.model isEqualToString:@"iPod"] && [self userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    
    return NO;
}

- (BOOL)alpha_isiPad {
    if ([self userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    
    return NO;
}

- (BOOL)alpha_isWatch {
    return ([[self model] containsString:@"Watch"]);
}

- (NSString *)alpha_systemInfoByName:(NSString *)name
{
    const char* typeSpecifier = [name cStringUsingEncoding:NSASCIIStringEncoding];
    
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    NSString *results = nil;
    
    if (size == 4) {
        uint32_t *answer = malloc(size);
        sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
        
        uint32_t final = EndianU32_NtoL(*answer);
        
        results = [NSString stringWithFormat:@"%d", final];
        
        free(answer);
    }
    else if (size == 8) {
        long long *answer = malloc(size);
        sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
        
        results = [NSString stringWithFormat:@"%lld", *answer];
        
        free(answer);
    }
    else if (size == 0) {
        results = @"0";
    }
    else
    {
        char *answer = malloc(size);
        sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
        
        results = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
        
        free(answer);
    }
    
    return results;
}

- (NSString *)alpha_modelIdentifier {
    return [self alpha_systemInfoByName:@"hw.machine"];
}

- (NSString *)alpha_modelName {
    return [self modelNameForModelIdentifier:[self alpha_modelIdentifier]];
}

- (NSString *)modelNameForModelIdentifier:(NSString *)modelIdentifier
{
    //
    // iPhone http://theiphonewiki.com/wiki/IPhone
    //
    
    if ([modelIdentifier isEqualToString:@"iPhone1,1"])
    {
        return @"iPhone 1G";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone1,2"])
    {
        return @"iPhone 3G";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone2,1"])
    {
        return @"iPhone 3GS";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone3,1"])
    {
        return @"iPhone 4 (GSM)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone3,2"])
    {
        return @"iPhone 4 (GSM Rev A)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone3,3"])
    {
        return @"iPhone 4 (CDMA)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone4,1"])
    {
        return @"iPhone 4S";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone5,1"])
    {
        return @"iPhone 5 (GSM)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone5,2"])
    {
        return @"iPhone 5 (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone5,3"])
    {
        return @"iPhone 5C (GSM)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone5,4"])
    {
        return @"iPhone 5C (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone6,1"])
    {
        return @"iPhone 5S (GSM)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone6,2"])
    {
        return @"iPhone 5S (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone7,1"])
    {
        return @"iPhone 6+ (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone7,2"])
    {
        return @"iPhone 6 (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone8,1"])
    {
        return @"iPhone 6s";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone8,2"])
    {
        return @"iPhone 6s Plus";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone8,4"])
    {
        return @"iPhone SE";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone9,1"])
    {
        return @"iPhone 7 (Verizon, Japan, China)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone9,2"])
    {
        return @"iPhone 7 Plus (Verizon, Japan, China)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone9,3"])
    {
        return @"iPhone 7 (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPhone9,4"])
    {
        return @"iPhone 7 Plus (Global)";
    }
    
    //
    // iPad http://theiphonewiki.com/wiki/IPad
    //
    
    if ([modelIdentifier isEqualToString:@"iPad1,1"])
    {
        return @"iPad Original";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad2,1"])
    {
        return @"iPad 2 (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad2,2"])
    {
        return @"iPad 2 (GSM)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad2,3"])
    {
        return @"iPad 2 (CDMA)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad2,4"])
    {
        return @"iPad 2 (Wi-Fi, Rev A)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad3,1"])
    {
        return @"iPad 3 (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad3,2"])
    {
        return @"iPad 3 (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad3,3"])
    {
        return @"iPad 3 (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad3,4"])
    {
        return @"iPad 4 (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad3,5"])
    {
        return @"iPad 4 (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad3,6"])
    {
        return @"iPad 4 (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,1"])
    {
        return @"iPad Air (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,2"])
    {
        return @"iPad Air (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,3"])
    {
        return @"iPad Air (China)";
    }
    
    //
    // iPad Air 2
    //
    
    if ([modelIdentifier isEqualToString:@"iPad5,3"])
    {
        return @"iPad Air 2";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad5,4"])
    {
        return @"iPad Air 2";
    }
    
    //
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    //
    
    if ([modelIdentifier isEqualToString:@"iPad2,5"])
    {
        return @"iPad Mini (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad2,6"])
    {
        return @"iPad Mini (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad2,7"])
    {
        return @"iPad Mini (Global)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,4"])
    {
        return @"iPad Mini Retina (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,5"])
    {
        return @"iPad Mini Retina (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,6"])
    {
        return @"iPad Mini Retina (China)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,7"])
    {
        return @"iPad Mini 3 (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,8"])
    {
        return @"iPad Mini 3 (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad4,9"])
    {
        return @"iPad Mini 3 (Cellular, China)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad5,1"])
    {
        return @"iPad Mini 4 (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad5,2"])
    {
        return @"iPad Mini 4 (Cellular)";
    }
    
    //
    // iPad Pro
    // http://www.everyi.com/by-identifier/ipod-iphone-ipad-specs-by-model-identifier.html
    //
    
    if ([modelIdentifier isEqualToString:@"iPad6,7"])
    {
        return @"iPad Pro 12.9-inch (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad6,8"])
    {
        return @"iPad Pro 12.9-inch (Cellular)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad6,3"])
    {
        return @"iPad Pro 9.7-inch (Wi-Fi)";
    }
    
    if ([modelIdentifier isEqualToString:@"iPad6,4"])
    {
        return @"iPad Pro 9.79-inch (Cellular)";
    }
    
    //
    // iPod http://theiphonewiki.com/wiki/IPod
    //
    
    if ([modelIdentifier isEqualToString:@"iPod1,1"])
    {
        return @"iPod Touch 1st Gen";
    }
    
    if ([modelIdentifier isEqualToString:@"iPod2,1"])
    {
        return @"iPod Touch 2nd Gen";
    }
    
    if ([modelIdentifier isEqualToString:@"iPod3,1"])
    {
        return @"iPod Touch 3rd Gen";
    }
    
    if ([modelIdentifier isEqualToString:@"iPod4,1"])
    {
        return @"iPod Touch 4th Gen";
    }
    
    if ([modelIdentifier isEqualToString:@"iPod5,1"])
    {
        return @"iPod Touch 5th Gen";
    }
    
    if ([modelIdentifier isEqualToString:@"iPod7,1"])
    {
        return @"iPod Touch 6th Gen";
    }
    
    //
    // Simulator
    //
    if ([modelIdentifier hasSuffix:@"86"] || [modelIdentifier isEqual:@"x86_64"]) {
        BOOL smallerScreen = ([[UIScreen mainScreen] bounds].size.width < 768.0);
        return (smallerScreen ? @"iPhone Simulator" : @"iPad Simulator");
    }
    
    //
    // Unknown device
    //
    
    return modelIdentifier;
}

- (ALPHADeviceFamily)alpha_deviceFamily
{
    NSString *modelIdentifier = [self alpha_modelIdentifier];
    
    if ([modelIdentifier hasPrefix:@"iPhone"]) {
        return ALPHADeviceFamilyiPhone;
    }
    
    if ([modelIdentifier hasPrefix:@"iPod"]) {
        return ALPHADeviceFamilyiPod;
    }
    
    if ([modelIdentifier hasPrefix:@"iPad"]) {
        return ALPHADeviceFamilyiPad;
    }
    
    if ([modelIdentifier containsString:@"Watch"]) {
        return ALPHADeviceFamilyWatch;
    }
    
    return ALPHADeviceFamilyUnknown;
}

@end
