//
//  FLEXNetworkError.h
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "JSONModel.h"

@interface FLEXNetworkError : JSONModel

@property (nonatomic, copy) NSString *domain;
@property (nonatomic) NSInteger code;

@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *localizedDescription;
@property (nonatomic, copy) NSString *localizedFailureReason;

+ (instancetype)networkErrorWithError:(NSError *)error;

@end
