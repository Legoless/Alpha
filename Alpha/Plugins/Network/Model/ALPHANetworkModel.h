//
//  ALPHANetworkModel.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"

#import "ALPHANetworkConnection.h"
#import "ALPHANetworkError.h"
#import "ALPHANetworkInitiator.h"
#import "ALPHANetworkRequest.h"
#import "ALPHANetworkConnectionTiming.h"
#import "ALPHANetworkResponse.h"

@interface ALPHANetworkModel : ALPHAModel

@property (nonatomic, strong) NSArray *requests;

@end
