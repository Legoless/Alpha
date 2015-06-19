//
//  ALPHATestCase.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHATestCase.h"

@implementation ALPHATestCase

- (void)assertDictionary:(NSDictionary *)d1 isEqualToDictionary:(NSDictionary *)d2 name1:(char const *)name1 name2:(char const *)name2 failureRecorder:(ALPHAFailureRecorder *)failureRecorder;
{
    NSSet *keys1 = [NSSet setWithArray:d1.allKeys];
    NSSet *keys2 = [NSSet setWithArray:d2.allKeys];
    if (! [keys1 isEqualToSet:keys2]) {
        XCTFail(@"Keys don't match for %s and %s", name1, name2);
        NSMutableSet *missingKeys = [keys1 mutableCopy];
        [missingKeys minusSet:keys2];
        if (0 < missingKeys.count) {
            [failureRecorder recordFailure:@"%s is missing keys: '%@'",
             name1, [[missingKeys allObjects] componentsJoinedByString:@"', '"]];
        }
        NSMutableSet *additionalKeys = [keys2 mutableCopy];
        [additionalKeys minusSet:keys1];
        if (0 < additionalKeys.count) {
            [failureRecorder recordFailure:@"%s has additional keys: '%@'",
             name1, [[additionalKeys allObjects] componentsJoinedByString:@"', '"]];
        }
    }
    for (id key in keys1) {
        if (! [d1[key] isEqual:d2[key]]) {
            [failureRecorder recordFailure:@"Value for '%@' in '%s' does not match '%s'. %@ == %@",
             key, name1, name2, d1[key], d2[key]];
        }
    }
}

@end
