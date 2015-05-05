//
//  NSString+Random.m
//

#import "NSString+Random.h"

typedef enum : NSUInteger {
    HSRandomStringTypeAlphaNumeric,
    HSRandomStringTypeAlpha,
    HSRandomStringTypeAny,
} HSRandomStringType;

@implementation NSString (Random)

+ (NSString *)hs_randomAlphaNumericStringOfLength:(NSUInteger)length
{
    return [self hs_randomStringWithType:HSRandomStringTypeAlphaNumeric length:length];
}

+ (NSString *)hs_randomAlphaStringOfLength:(NSUInteger)length
{
    return [self hs_randomStringWithType:HSRandomStringTypeAlpha length:length];
}

+ (NSString *)hs_randomStringOfLength:(NSUInteger)length
{
    return [self hs_randomStringWithType:HSRandomStringTypeAny length:length];
}

+ (NSString *)hs_randomStringWithType:(HSRandomStringType)type length:(NSUInteger)length;
{
    NSString* baseCharacters = nil;
    
    switch (type)
    {
        case HSRandomStringTypeAlpha:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case HSRandomStringTypeAlphaNumeric:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            break;
        case HSRandomStringTypeAny:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&/()=?+<>-_,.[]{}@:;";
            break;
    }
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (NSUInteger i = 0; i < length; i++)
    {
        [randomString appendFormat:@"%C", [baseCharacters characterAtIndex:arc4random() % [baseCharacters length]]];
    }
    
    return randomString;
}

@end
