//
//  UIDevice+Hardware.m
//

#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>

#import "UIDevice+Hardware.h"

#import "UIDevice+DeviceInfo.h"

@implementation UIDevice (Hardware)

- (float)hs_batteryLevel
{
    BOOL batteryMonitoring = self.batteryMonitoringEnabled;
    
    if (!batteryMonitoring)
    {
        self.batteryMonitoringEnabled = YES;
    }
    
    [self setBatteryMonitoringEnabled:YES];
    
    float batteryLevel = self.batteryLevel;
    
    if (!batteryMonitoring)
    {
        self.batteryMonitoringEnabled = NO;
    }
    
    return batteryLevel;
}

#pragma mark - CPU related

- (NSUInteger)hs_cpuCount
{
    return (NSUInteger)[[self systemInfoByName:@"hw.ncpu"] integerValue];
}

- (NSUInteger)hs_cpuActiveCount
{
    return (NSUInteger)[[self systemInfoByName:@"hw.activecpu"] integerValue];
}

- (NSUInteger)hs_cpuPhysicalCount
{
    return (NSUInteger)[[self systemInfoByName:@"hw.physicalcpu"] integerValue];
}

- (NSUInteger)hs_cpuPhysicalMaximumCount
{
    return (NSUInteger)[[self systemInfoByName:@"hw.physicalcpu_max"] integerValue];
}

- (NSUInteger)hs_cpuLogicalCount
{
    return (NSUInteger)[[self systemInfoByName:@"hw.logicalcpu"] integerValue];
}

- (NSUInteger)hs_cpuLogicalMaximumCount
{
    return (NSUInteger)[[self systemInfoByName:@"hw.logicalcpu_max"] integerValue];
}

- (NSUInteger)hs_cpuFrequency
{
    return (NSUInteger)[[self systemInfoByName:@"hw.cpufrequency"] integerValue];
}

- (NSUInteger)hs_cpuMaximumFrequency
{
    return (NSUInteger)[[self systemInfoByName:@"hw.cpufrequency_max"] integerValue];
}

- (NSUInteger)hs_cpuMinimumFrequency
{
    return (NSUInteger)[[self systemInfoByName:@"hw.cpufrequency_min"] integerValue];
}

- (NSString *)hs_cpuType
{
    NSString *cpuType = [self systemInfoByName:@"hw.cputype"];
    
    switch (cpuType.integerValue)
    {
        case 1:
            return @"VAC";
        case 6:
            return @"MC680x0";
        case 7:
            return @"x86";
        case 10:
            return @"MC88000";
        case 11:
            return @"HPPA";
        case 12:
        case 16777228:
            return @"arm";
        case 13:
            return @"MC88000";
        case 14:
            return @"Sparc";
        case 15:
            return @"i860";
        case 18:
            return @"PowerPC";
        default:
            return @"Any";
    }
}

- (NSString *)hs_cpuSubType
{
    return [self systemInfoByName:@"hw.cpusubtype"];
}

- (NSString *)hs_cpuArchitectures
{
    NSMutableArray *architectures = [NSMutableArray array];
    
    NSInteger type = [self systemInfoByName:@"hw.cputype"].integerValue;
    NSInteger subtype = [self systemInfoByName:@"hw.cpusubtype"].integerValue;
    
    if (type == CPU_TYPE_X86)
    {
        [architectures addObject:@"x86"];
        
        if (subtype == CPU_SUBTYPE_X86_64_ALL || subtype == CPU_SUBTYPE_X86_64_H)
        {
            [architectures addObject:@"x86_64"];
        }
    }
    else
    {
        if (subtype == CPU_SUBTYPE_ARM_V6)
        {
            [architectures addObject:@"armv6"];
        }
        
        if (subtype == CPU_SUBTYPE_ARM_V7)
        {
            [architectures addObject:@"armv7"];
        }
        
        if (subtype == CPU_SUBTYPE_ARM_V7S)
        {
            [architectures addObject:@"armv7s"];
        }
        
        if (subtype == CPU_SUBTYPE_ARM64_V8)
        {
            [architectures addObject:@"arm64"];
        }
    }
    
    return [architectures componentsJoinedByString:@", "];
}


#pragma mark - Memory Related

- (unsigned long long)hs_memoryMarketingSize
{
    unsigned long long totalSpace = [self hs_memoryPhysicalSize];
    
    double next = pow(2, ceil (log (totalSpace) / log(2)));
    
    return (unsigned long long)next;

}

- (unsigned long long)hs_memoryPhysicalSize
{
    return (unsigned long long)[[self systemInfoByName:@"hw.memsize"] longLongValue];
}

#pragma mark - Disk Space Related

- (unsigned long long)hs_diskMarketingSpace
{
    unsigned long long totalSpace = [self hs_diskTotalSpace];
    
    double next = pow(2, ceil (log (totalSpace) / log(2)));
    
    return (unsigned long long)next;
}

- (unsigned long long)hs_diskTotalSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] unsignedLongLongValue];
}

- (unsigned long long)hs_diskFreeSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] unsignedLongLongValue];
}

@end
