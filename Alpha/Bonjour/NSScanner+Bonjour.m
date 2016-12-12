//
//  NSScanner+Bonjour.m
//  Alpha
//
//  Created by Dal Rupnik on 12/12/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

//
// This file is ported from DTBonjour library, by Oliver Drobnik
//

#import "NSScanner+Bonjour.h"

@implementation NSScanner (Bonjour)

- (BOOL)alpha_scanBonjourConnectionHeaders:(NSDictionary **)headers
{
    NSString *headerName;
    
    NSUInteger positionBeforeScanning = [self scanLocation];
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    
    while (!self.isAtEnd)
    {
        if (![self scanUpToString:@":" intoString:&headerName])
        {
            self.scanLocation = positionBeforeScanning;
            return NO;
        }
        
        // skip colon
        [self scanString:@":" intoString:NULL];
        
        NSString *headerValue;
        if ([self scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&headerValue])
        {
            tmpDict[headerName] = headerValue;
        }
    }
    
    if (headers)
    {
        *headers = [tmpDict copy];
    }
    
    return YES;
}

@end
