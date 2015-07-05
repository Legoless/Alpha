//
//  NSString+Validation.m
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)hay_isValidEmail
{
    return [self hay_isValidEmailWithStrictFilter:YES];
}

- (BOOL)hay_isValidEmailWithStrictFilter:(BOOL)strict
{
    //
    // Discussion http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
    //
    
    BOOL stricterFilter = strict;
    NSString *stricterFilterString = @"[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}
@end
