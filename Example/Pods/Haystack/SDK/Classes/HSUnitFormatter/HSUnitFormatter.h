@import Foundation;

typedef enum : NSUInteger {
    HSUnitFormatterUnitTypeHertz,
    HSUnitFormatterUnitTypeMeter
} HSUnitFormatterUnitType;

@interface HSUnitFormatter : NSFormatter

@property (nonatomic, copy) NSString *unit;

+ (NSString *)stringFromNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit;

+ (NSString *)fullStringFromNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit;

@end
