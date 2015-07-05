//
//  HAYUnitFormatterPrefix.m
//

#import "HAYUnitFormatterPrefix.h"

@implementation HAYUnitFormatterPrefix

+ (instancetype)unitFormatterPrefixForPrefix:(NSString *)prefix symbol:(NSString *)symbol decimal:(double)decimal shortScaleWord:(NSString *)shortScaleWord longScaleWord:(NSString *)longScaleWord
{
    HAYUnitFormatterPrefix *formatterPrefix = [[HAYUnitFormatterPrefix alloc] init];
    
    formatterPrefix.prefix = prefix;
    formatterPrefix.symbol = symbol;
    formatterPrefix.decimal = decimal;
    formatterPrefix.shortScaleWord = shortScaleWord;
    formatterPrefix.longScaleWord = longScaleWord;
    
    return formatterPrefix;
}

@end
