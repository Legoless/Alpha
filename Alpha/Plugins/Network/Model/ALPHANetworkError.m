//
//  ALPHANetworkError.m
//  Alpha
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHANetworkError.h"

@implementation ALPHANetworkError

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (instancetype)networkErrorWithError:(NSError *)error {
    if (!error) {
        return nil;
    }
    
    ALPHANetworkError *networkError = [[ALPHANetworkError alloc] init];
    
    networkError.domain = error.domain;
    networkError.code = error.code;
    networkError.userInfo = error.userInfo;
    networkError.localizedDescription = error.localizedDescription;
    networkError.localizedFailureReason = error.localizedFailureReason;
    
    return networkError;
}

@end
