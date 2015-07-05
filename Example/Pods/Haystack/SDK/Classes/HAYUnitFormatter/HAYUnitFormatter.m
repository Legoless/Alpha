#import "HAYUnitFormatter.h"
#import "HAYUnitFormatterPrefix.h"
#import "HAYUnitFormatterUnit.h"

@interface HAYUnitFormatter ()

@end

@implementation HAYUnitFormatter

+ (NSDictionary *)units
{
    static NSDictionary *units = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        NSMutableDictionary *baseUnits = [NSMutableDictionary dictionary];
        
        baseUnits[@(HSUnitFormatterUnitTypeHertz)] = [HAYUnitFormatterUnit unitFormatterUnitForFullName:@"Hertz" shortName:@"Hz" excludedPrefixes:@[ @"deca", @"hecto", @"deci", @"centi" ]];
        baseUnits[@(HSUnitFormatterUnitTypeMeter)] = [HAYUnitFormatterUnit unitFormatterUnitForFullName:@"meter" shortName:@"m" excludedPrefixes:@[ @"deca", @"hecto" ]];
        
        units = [baseUnits copy];
    });
    
    return units;
}

+ (NSArray *)prefixes
{
    //
    // Prefixes basd on BIPM (part of SI)
    //
    
    static NSArray *prefixes = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        NSMutableArray* basePrefixes = [NSMutableArray array];
        
        //
        // SI-based prefixes
        //
        
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"yotta" symbol:@"Y" decimal:1000000000000000000000000.0 shortScaleWord:@"septillion" longScaleWord:@"quadrillion"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"zetta" symbol:@"Z" decimal:1000000000000000000000.0 shortScaleWord:@"sextillion" longScaleWord:@"thousand trillion"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"exa" symbol:@"E" decimal:1000000000000000000.0 shortScaleWord:@"quintillion" longScaleWord:@"trillion"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"peta" symbol:@"P" decimal:1000000000000000.0 shortScaleWord:@"quadrillion" longScaleWord:@"thousand billion"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"tera" symbol:@"T" decimal:1000000000000.0 shortScaleWord:@"trillion" longScaleWord:@"billion"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"giga" symbol:@"G" decimal:1000000000.0 shortScaleWord:@"billion" longScaleWord:@"thousand million"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"mega" symbol:@"M" decimal:1000000.0 shortScaleWord:@"million" longScaleWord:@"million"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"kilo" symbol:@"k" decimal:1000.0 shortScaleWord:@"thousand" longScaleWord:@"thousand"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"hecto" symbol:@"h" decimal:100.0 shortScaleWord:@"hundred" longScaleWord:@"hundred"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"deca" symbol:@"da" decimal:10.0 shortScaleWord:@"ten" longScaleWord:@"ten"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"deci" symbol:@"d" decimal:0.1 shortScaleWord:@"tenth" longScaleWord:@"tenth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"centi" symbol:@"c" decimal:0.01 shortScaleWord:@"hundredth" longScaleWord:@"hundredth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"milli" symbol:@"m" decimal:0.001 shortScaleWord:@"thousandth" longScaleWord:@"thousandth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"micro" symbol:@"μ" decimal:0.000001 shortScaleWord:@"millionth" longScaleWord:@"millionth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"nano" symbol:@"n" decimal:0.000000001 shortScaleWord:@"billionth" longScaleWord:@"thousand millionth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"pico" symbol:@"p" decimal:0.000000000001 shortScaleWord:@"trillionth" longScaleWord:@"billionth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"femto" symbol:@"f" decimal:0.000000000000001 shortScaleWord:@"quadrillionth" longScaleWord:@"thousand billionth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"atto" symbol:@"a" decimal:0.000000000000000001 shortScaleWord:@"quintillionth" longScaleWord:@"trillionth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"zepto" symbol:@"z" decimal:0.000000000000000000001 shortScaleWord:@"sextillionth" longScaleWord:@"thousand trillionth"]];
        [basePrefixes addObject:[HAYUnitFormatterPrefix unitFormatterPrefixForPrefix:@"yocto" symbol:@"y" decimal:0.000000000000000000000001 shortScaleWord:@"septillionth" longScaleWord:@"quadrillionth"]];
        
        prefixes = [basePrefixes copy];
    });
    
    return prefixes;
}

+ (NSString *)stringFromNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit
{
    HAYUnitFormatterPrefix *prefix = [self prefixForNumber:number forUnit:unit];
    HAYUnitFormatterUnit * formatterUnit = [self units][@(unit)];
    
    double num = number.doubleValue / prefix.decimal;
    
    if (number.longLongValue == 0)
    {
        return [NSString stringWithFormat:@"%.1f %@", 0.0, formatterUnit.shortName];
    }
    
    return [NSString stringWithFormat:@"%.1f %@%@", num, prefix.symbol, formatterUnit.shortName];
}

+ (NSString *)fullStringFromNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit
{
    HAYUnitFormatterPrefix *prefix = [self prefixForNumber:number forUnit:unit];
    HAYUnitFormatterUnit * formatterUnit = [self units][@(unit)];
    
    double num = number.doubleValue / prefix.decimal;
    
    if (number.longLongValue == 0)
    {
        return [NSString stringWithFormat:@"%.1f %@", 0.0, formatterUnit.fullName];
    }
    
    return [NSString stringWithFormat:@"%.1f %@%@", num, prefix.prefix, formatterUnit.fullName];
}

+ (HAYUnitFormatterPrefix *)prefixForNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit
{
    NSArray* prefixes = [self prefixes];
    
    HAYUnitFormatterUnit * formatterUnit = [self units][@(unit)];
    
    HAYUnitFormatterPrefix *selectedPrefix = nil;
    
    double min = number.doubleValue;
    
    for (HAYUnitFormatterPrefix * prefix in prefixes)
    {
        //
        // Skip excluded prefix
        //
        if ([formatterUnit.excludedPrefixes containsObject:prefix.prefix])
        {
            continue;
        }
        
        if (number.doubleValue / prefix.decimal < min && number.doubleValue / prefix.decimal > 1.0)
        {
            min = number.doubleValue / prefix.decimal;
            selectedPrefix = prefix;
        }
    }
    
    return selectedPrefix;
}

@end
