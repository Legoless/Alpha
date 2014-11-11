//
//  NSString+Additional.m
//

#import "NSString+Additional.h"

@implementation NSString (Additional)

- (BOOL)endsWith:(NSString *)string
{
    return [self hasSuffix:string];
}

- (BOOL)startsWith:(NSString *)string
{
    return [self hasPrefix:string];
}

@end