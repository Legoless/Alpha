//
//  NSURL+Parameters.m
//

#import "NSURL+Parameters.h"

@implementation NSURL (Parameters)

- (NSDictionary *)queryParameters
{
    NSString* url = [self query];
    
    if (!url.length)
    {
        return nil;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    for (NSString *parameter in [url componentsSeparatedByString:@"&"])
    {
        NSRange range = [parameter rangeOfString:@"="];
        
        if (range.location != NSNotFound)
        {
            parameters[[[parameter substringToIndex:range.location] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]] = [[parameter substringFromIndex:range.location + range.length] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            parameters[[parameter stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]] = @"";
        }
    }
    
    return [parameters copy];
}

- (NSURL *)urlByAppendingParameter:(NSString *)parameter value:(NSString *)value
{
    return [self urlByAppendingParameters:@{ parameter : value }];
}

- (NSURL *)urlByAppendingParameters:(NSDictionary *)parameters
{
    NSMutableString *absoluteURL = [[self absoluteString] mutableCopy];
    
    for (id parameter in parameters)
    {
        NSString *prefix = @"?";
        
        if ([absoluteURL rangeOfString:prefix].location != NSNotFound)
        {
            prefix = @"&";
        }
        
        [absoluteURL appendFormat:@"%@%@=%@", prefix, parameter, parameters[parameter]];
    }
    
    return [[self class] URLWithString:absoluteURL];
}

@end
