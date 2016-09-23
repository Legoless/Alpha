//
//  ALPHANetworkRequest.m
//  Alpha
//
//  Created by Dal Rupnik on 06/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHANetworkRequest.h"

@implementation ALPHANetworkRequest

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithURLRequest:(NSURLRequest *)request {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.url = [request.URL absoluteString];
    self.method = request.HTTPMethod;
    self.headers = request.allHTTPHeaderFields;
    
    
    NSData *body = request.HTTPBody;
    
    self.postData = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    
    return self;
}

+ (ALPHANetworkRequest *)networkRequestWithURLRequest:(NSURLRequest *)request {
    return [[[self class] alloc] initWithURLRequest:request];
}

@end
