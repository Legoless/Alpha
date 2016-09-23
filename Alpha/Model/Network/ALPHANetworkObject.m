//
//  ALPHANetworkObject.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"

#import "ALPHANetworkObject.h"

NSString *const ALPHANetworkObjectVerificationKey = @"kALPHANetworkObjectVerificationKey";

@interface ALPHANetworkObject ()

@end

@implementation ALPHANetworkObject

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
