//
//  FLEXNetworkError.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXNetworkError.h"

@implementation FLEXNetworkError

+ (instancetype)networkErrorWithError:(NSError *)error
{
    FLEXNetworkError *networkError = [[FLEXNetworkError alloc] init];
    
    networkError.domain = error.domain;
    networkError.code = error.code;
    networkError.userInfo = error.userInfo;
    networkError.localizedDescription = error.localizedDescription;
    networkError.localizedFailureReason = error.localizedFailureReason;
    
    return networkError;
}

@end
