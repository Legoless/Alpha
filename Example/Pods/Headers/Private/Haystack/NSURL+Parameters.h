//
//  NSURL+Parameters.h
//

@import Foundation;

@interface NSURL (Parameters)

- (NSDictionary *)queryParameters;

- (NSURL *)urlByAppendingParameter:(NSString *)parameter value:(NSString *)value;

- (NSURL *)urlByAppendingParameters:(NSDictionary *)parameters;

@end
