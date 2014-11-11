//
//  NSString+Validation.h
//

@import Foundation;

@interface NSString (Validation)

- (BOOL)isValidEmail;

- (BOOL)isValidEmailWithStrictFilter:(BOOL)strict;

@end
