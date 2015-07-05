//
//  NSString+Additional.m
//

#import "NSString+Additional.h"

@implementation NSString (Additional)

- (BOOL)hay_endsWith:(NSString *)string
{
    return [self hasSuffix:string];
}

- (BOOL)hay_startsWith:(NSString *)string
{
    return [self hasPrefix:string];
}

- (NSUInteger)hay_numberOfOccurencesOfString:(NSString *)string
{
    NSUInteger count = 0;
    NSUInteger length = [self length];
    
    NSRange range = NSMakeRange(0, length);
    
    while (range.location != NSNotFound)
    {
        range = [self rangeOfString:string options:0 range:range];
        
        if (range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++; 
        }
    }
    
    return count;
}

@end