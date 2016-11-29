//
//  NSString+Random.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//
#import "NSString+Random.h"

typedef enum : NSUInteger {
    ALPHARandomStringTypeAlphaNumeric,
    ALPHARandomStringTypeAlpha,
    ALPHARandomStringTypeAny,
} ALPHARandomStringType;

@implementation NSString (Random)

+ (NSString *)alpha_randomAlphaNumericStringOfLength:(NSUInteger)length {
    return [self alpha_randomStringWithType:ALPHARandomStringTypeAlphaNumeric length:length];
}

+ (NSString *)alpha_randomAlphaStringOfLength:(NSUInteger)length {
    return [self alpha_randomStringWithType:ALPHARandomStringTypeAlpha length:length];
}

+ (NSString *)alpha_randomStringOfLength:(NSUInteger)length {
    return [self alpha_randomStringWithType:ALPHARandomStringTypeAny length:length];
}

+ (NSString *)alpha_randomStringWithType:(ALPHARandomStringType)type length:(NSUInteger)length; {
    NSString* baseCharacters = nil;
    
    switch (type) {
        case ALPHARandomStringTypeAlpha:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case ALPHARandomStringTypeAlphaNumeric:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            break;
        case ALPHARandomStringTypeAny:
            baseCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&/()=?+<>-_,.[]{}@:;";
            break;
    }
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (NSUInteger i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [baseCharacters characterAtIndex:arc4random() % [baseCharacters length]]];
    }
    
    return randomString;
}

+ (NSString *)alpha_UUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString;
}

@end
