//
//  ALPHANetworkResponse.m
//  Alpha
//
//  Created by Dal Rupnik on 06/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHANetworkResponse.h"

@implementation ALPHANetworkResponse

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithURLResponse:(NSURLResponse *)response request:(NSURLRequest *)request {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    if (!response) {
        return nil;
    }
    
    self.url = [response.URL absoluteString];
    
    // Set statusText if this was a HTTP Response
    self.statusText = @"";
    
    self.mimeType = response.MIMEType;
    self.requestHeaders = request.allHTTPHeaderFields;
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        self.status = [NSNumber numberWithInteger:httpResponse.statusCode];
        self.statusText = [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode];
        self.headers = httpResponse.allHeaderFields;
    }
    
    return self;
}

+ (ALPHANetworkResponse *)networkResponseWithURLResponse:(NSURLResponse *)response request:(NSURLRequest *)request {
    return [[[self class] alloc] initWithURLResponse:response request:request];
}

@end
