//
//  HSUnitFormatterPrefix.h
//

@import Foundation;

@interface HSUnitFormatterPrefix : NSObject

@property (nonatomic, copy) NSString *prefix;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic) double decimal;
@property (nonatomic, copy) NSString *shortScaleWord;
@property (nonatomic, copy) NSString *longScaleWord;

+ (instancetype)unitFormatterPrefixForPrefix:(NSString *)prefix symbol:(NSString *)symbol decimal:(double)decimal shortScaleWord:(NSString *)shortScaleWord longScaleWord:(NSString *)longScaleWord;

@end
