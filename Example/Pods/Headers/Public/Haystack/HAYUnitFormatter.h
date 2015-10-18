@import Foundation;

typedef enum : NSUInteger {
    HSUnitFormatterUnitTypeHertz,
    HSUnitFormatterUnitTypeMeter
} HSUnitFormatterUnitType;

@interface HAYUnitFormatter : NSFormatter

@property (nonatomic, copy) NSString *unit;

+ (NSString *)stringFromNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit;

+ (NSString *)fullStringFromNumber:(NSNumber *)number forUnit:(HSUnitFormatterUnitType)unit;

@end
