//
//  NSString+Validation.h
//

@import Foundation;

@interface NSString (Validation)

- (BOOL)hay_isValidEmail;

- (BOOL)hay_isValidEmailWithStrictFilter:(BOOL)strict;

@end
