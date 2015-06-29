//
//  ALPHATestCase.h
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import XCTest;
@import Foundation;

#import "ALPHAFailureRecorder.h"

#define ALPHAAssertEqualDictionaries(d1, d2) \
do { \
[self assertDictionary:d1 isEqualToDictionary:d2 name1:#d1 name2:#d2 failureRecorder:NewFailureRecorder()]; \
} while (0)

@interface ALPHATestCase : XCTestCase

- (void)assertDictionary:(NSDictionary *)d1 isEqualToDictionary:(NSDictionary *)d2 name1:(char const *)name1 name2:(char const *)name2 failureRecorder:(ALPHAFailureRecorder *)failureRecorder;

@end
