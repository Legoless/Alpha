//
//  HSUnitFormatterUnit.h
//

@import Foundation;

@interface HSUnitFormatterUnit : NSObject

@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *shortName;

/**
 *  Defines which prefixes are excluded, for example, we have no (hecto meters)
 */
@property (nonatomic, copy) NSArray *excludedPrefixes;

+ (instancetype)unitFormatterUnitForFullName:(NSString *)fullName shortName:(NSString *)shortName excludedPrefixes:(NSArray *)excludedPrefixes;

@end
