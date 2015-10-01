//
//  NSString+Data.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "NSString+Data.h"

@implementation NSString (Data)

+ (NSString *)alpha_hexStringFromData:(NSData *)data
{
    // Convert device deviceToken to a hex string
    NSMutableString *deviceToken = [NSMutableString stringWithCapacity:([data length] * 2)];
    const unsigned char *bytes = (const unsigned char *)[data bytes];
    
    for (NSUInteger i = 0; i < [data length]; i++) {
        [deviceToken appendFormat:@"%02X", bytes[i]];
    }
    
    return [deviceToken lowercaseString];
}

@end
