//
//  HSUnitFormatterUnit.m
//

#import "HSUnitFormatterUnit.h"

@implementation HSUnitFormatterUnit

+ (instancetype)unitFormatterUnitForFullName:(NSString *)fullName shortName:(NSString *)shortName excludedPrefixes:(NSArray *)excludedPrefixes
{
    HSUnitFormatterUnit *unit = [[HSUnitFormatterUnit alloc] init];
    
    unit.fullName = fullName;
    unit.shortName = shortName;
    unit.excludedPrefixes = excludedPrefixes;
    
    return unit;
}

@end
