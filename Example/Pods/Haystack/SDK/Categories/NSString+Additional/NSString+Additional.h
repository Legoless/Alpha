//
//  NSString+Additional.h
//

@import Foundation;

@interface NSString (Additional)

- (BOOL)hay_endsWith:(NSString *)string;

- (BOOL)hay_startsWith:(NSString *)string;

- (NSUInteger)hay_numberOfOccurencesOfString:(NSString *)string;

@end
