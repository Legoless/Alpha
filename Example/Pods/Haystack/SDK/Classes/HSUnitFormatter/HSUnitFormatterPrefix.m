//
//  HSUnitFormatterPrefix.m
//

#import "HSUnitFormatterPrefix.h"

@implementation HSUnitFormatterPrefix

+ (instancetype)unitFormatterPrefixForPrefix:(NSString *)prefix symbol:(NSString *)symbol decimal:(double)decimal shortScaleWord:(NSString *)shortScaleWord longScaleWord:(NSString *)longScaleWord
{
    HSUnitFormatterPrefix *formatterPrefix = [[HSUnitFormatterPrefix alloc] init];
    
    formatterPrefix.prefix = prefix;
    formatterPrefix.symbol = symbol;
    formatterPrefix.decimal = decimal;
    formatterPrefix.shortScaleWord = shortScaleWord;
    formatterPrefix.longScaleWord = longScaleWord;
    
    return formatterPrefix;
}

@end
