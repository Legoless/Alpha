//
//  NSURL+Parameters.h
//

@import Foundation;

@interface NSURL (Parameters)

- (NSDictionary *)hay_queryParameters;

- (NSURL *)hay_urlByAppendingParameter:(NSString *)parameter value:(NSString *)value;

- (NSURL *)hay_urlByAppendingParameters:(NSDictionary *)parameters;

@end
