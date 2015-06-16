//
//  NSString+Random.h
//

@import Foundation;

@interface NSString (Random)

/*!
 *  Returns random alpha-numeric string
 *
 *  @param length of string
 *
 *  @return random string
 */
+ (NSString *)hs_randomAlphaNumericStringOfLength:(NSUInteger)length;

/*!
 *  Returns random alpha string (no numbers)
 *
 *  @param length of string
 *
 *  @return random string
 */
+ (NSString *)hs_randomAlphaStringOfLength:(NSUInteger)length;

/*!
 *  Returns random string that can contain all ASCII characters
 *
 *  @param length of string
 *
 *  @return random string
 */
+ (NSString *)hs_randomStringOfLength:(NSUInteger)length;

/*!
 *  Returns random new UUID
 *
 *  @return random UUID
 */
+ (NSString *)hs_UUID;

@end
