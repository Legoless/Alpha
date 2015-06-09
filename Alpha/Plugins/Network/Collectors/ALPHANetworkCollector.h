//
//  ALPHANetworkCollector.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHABaseDataSource.h"

extern NSString *const ALPHANetworkDataIdentifier;

@interface ALPHANetworkCollector : ALPHABaseDataSource

/*!
 *  Network collector can only be one, so we use singleton approach, to add access to it.
 *  The reason for this is that it does quite a lot of swizzling that references the 
 *  singleton.
 *
 *  @return shared instance
 */
+ (instancetype)sharedCollector;


+ (void)injectIntoAllNSURLConnectionDelegateClasses;
+ (void)swizzleNSURLSessionClasses;
+ (void)injectIntoDelegateClass:(Class)cls;

@end


@interface ALPHANetworkCollector (NSURLConnectionHelpers)

- (void)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end

@interface ALPHANetworkCollector (NSURLSessionTaskHelpers)

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;

@end
