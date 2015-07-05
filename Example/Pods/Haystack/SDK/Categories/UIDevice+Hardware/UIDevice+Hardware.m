//
//  UIDevice+Hardware.m
//

#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>

#import "UIDevice+Hardware.h"

#import "UIDevice+DeviceInfo.h"

@implementation UIDevice (Hardware)

- (float)hay_batteryLevel
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

- (NSUInteger)hay_cpuCount
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.ncpu"] integerValue];
}

- (NSUInteger)hay_cpuActiveCount
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.activecpu"] integerValue];
}

- (NSUInteger)hay_cpuPhysicalCount
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.physicalcpu"] integerValue];
}

- (NSUInteger)hay_cpuPhysicalMaximumCount
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.physicalcpu_max"] integerValue];
}

- (NSUInteger)hay_cpuLogicalCount
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.logicalcpu"] integerValue];
}

- (NSUInteger)hay_cpuLogicalMaximumCount
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.logicalcpu_max"] integerValue];
}

- (NSUInteger)hay_cpuFrequency
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.cpufrequency"] integerValue];
}

- (NSUInteger)hay_cpuMaximumFrequency
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.cpufrequency_max"] integerValue];
}

- (NSUInteger)hay_cpuMinimumFrequency
{
    return (NSUInteger)[[self hay_systemInfoByName:@"hw.cpufrequency_min"] integerValue];
}

- (NSString *)hay_cpuType
{
    NSString *cpuType = [self hay_systemInfoByName:@"hw.cputype"];
    
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

- (NSString *)hay_cpuSubType
{
    return [self hay_systemInfoByName:@"hw.cpusubtype"];
}

- (NSString *)hay_cpuArchitectures
{
    NSMutableArray *architectures = [NSMutableArray array];
    
    NSInteger type = [self hay_systemInfoByName:@"hw.cputype"].integerValue;
    NSInteger subtype = [self hay_systemInfoByName:@"hw.cpusubtype"].integerValue;
    
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

- (unsigned long long)hay_memoryMarketingSize
{
    unsigned long long totalSpace = [self hay_memoryPhysicalSize];
    
    double next = pow(2, ceil (log (totalSpace) / log(2)));
    
    return (unsigned long long)next;

}

- (unsigned long long)hay_memoryPhysicalSize
{
    return (unsigned long long)[[self hay_systemInfoByName:@"hw.memsize"] longLongValue];
}

#pragma mark - Disk Space Related

- (unsigned long long)hay_diskMarketingSpace
{
    unsigned long long totalSpace = [self hay_diskTotalSpace];
    
    double next = pow(2, ceil (log (totalSpace) / log(2)));
    
    return (unsigned long long)next;
}

- (unsigned long long)hay_diskTotalSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] unsignedLongLongValue];
}

- (unsigned long long)hay_diskFreeSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] unsignedLongLongValue];
}

@end
