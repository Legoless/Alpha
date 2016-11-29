//
//  NSString+Random.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
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
+ (NSString *)alpha_randomAlphaNumericStringOfLength:(NSUInteger)length;

/*!
 *  Returns random alpha string (no numbers)
 *
 *  @param length of string
 *
 *  @return random string
 */
+ (NSString *)alpha_randomAlphaStringOfLength:(NSUInteger)length;

/*!
 *  Returns random string that can contain all ASCII characters
 *
 *  @param length of string
 *
 *  @return random string
 */
+ (NSString *)alpha_randomStringOfLength:(NSUInteger)length;

/*!
 *  Returns random new UUID
 *
 *  @return random UUID
 */
+ (NSString *)alpha_UUID;

@end
