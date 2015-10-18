//
//  NSDate+Additional.h
//

@import Foundation;

@interface NSDate (Additional)

/*!
 *  Compares NSDate date part to another NSDate.
 *
 *  @param NSDate date to be compared
 *  @return NSComparisonResult result of comparison
 */
- (NSComparisonResult)hay_compareDateWithoutTimeTo:(NSDate *)date;

@end
