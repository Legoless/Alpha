//
//  HAYUnitFormatterUnit.m
//

#import "HAYUnitFormatterUnit.h"

@implementation HAYUnitFormatterUnit

+ (instancetype)unitFormatterUnitForFullName:(NSString *)fullName shortName:(NSString *)shortName excludedPrefixes:(NSArray *)excludedPrefixes
{
    HAYUnitFormatterUnit *unit = [[HAYUnitFormatterUnit alloc] init];
    
    unit.fullName = fullName;
    unit.shortName = shortName;
    unit.excludedPrefixes = excludedPrefixes;
    
    return unit;
}

@end
