//
//  ALPHANetworkError.h
//  Alpha
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

@interface ALPHANetworkError : NSObject <ALPHASerializableItem>

@property (nonatomic, copy) NSString *domain;
@property (nonatomic) NSInteger code;

@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *localizedDescription;
@property (nonatomic, copy) NSString *localizedFailureReason;

+ (instancetype)networkErrorWithError:(NSError *)error;

@end
