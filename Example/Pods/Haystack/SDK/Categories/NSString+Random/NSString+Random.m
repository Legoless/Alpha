//
//  NSString+Random.m
//

#import "NSString+Random.h"

typedef enum : NSUInteger {
    HAYRandomStringTypeAlphaNumeric,
    HAYRandomStringTypeAlpha,
    HAYRandomStringTypeAny,
} HAYRandomStringType;

@implementation NSString (Random)

+ (NSString *)hay_randomAlphaNumericStringOfLength:(NSUInteger)length
{
    return [self hay_randomStringWithType:HAYRandomStringTypeAlphaNumeric length:length];
}

+ (NSString *)hay_randomAlphaStringOfLength:(NSUInteger)length
{
    return [self hay_randomStringWithType:HAYRandomStringTypeAlpha length:length];
}

+ (NSString *)hay_randomStringOfLength:(NSUInteger)length
{
    return [self hay_randomStringWithType:HAYRandomStringTypeAny length:length];
}

+ (NSString *)hay_randomStringWithType:(HAYRandomStringType)type length:(NSUInteger)length;
{
    NSString* baseCharacters = nil;
    
    switch (type)
    {
        case HAYRandomStringTypeAlpha:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case HAYRandomStringTypeAlphaNumeric:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            break;
        case HAYRandomStringTypeAny:
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

+ (NSString *)hay_UUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString;
}

@end
