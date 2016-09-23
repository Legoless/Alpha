//
//  ALPHANetworkConnection.m
//  Alpha
//
//  Created by Dal Rupnik on 06/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHANetworkConnection.h"

@implementation ALPHANetworkConnection

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)updateWithRequest:(ALPHANetworkRequest *)request withResponse:(ALPHANetworkResponse *)response
{
    if (request)
    {
        self.request = request;
    }
    
    if (response)
    {
        self.response = response;
    }
}

- (NSNumber *)size
{
    return @(self.responseData.length);
}

- (NSString *)responseString
{
    return [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
}

@end
