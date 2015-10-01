//
//  ALPHANetworkRequest.h
//  Alpha
//
//  Created by Dal Rupnik on 06/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHANetworkRequest : NSObject <ALPHASerializableItem>

// Request URL.
// Type: string
@property (nonatomic, strong) NSString *url;

// HTTP request method.
// Type: string
@property (nonatomic, strong) NSString *method;

// HTTP request headers.
@property (nonatomic, strong) NSDictionary *headers;

// HTTP POST request data.
// Type: string
@property (nonatomic, strong) NSString *postData;

- (id)initWithURLRequest:(NSURLRequest *)request;
+ (ALPHANetworkRequest *)networkRequestWithURLRequest:(NSURLRequest *)request;

@end