//
//  ALPHAFailureRecorder.h
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <XCTest/XCTest.h>

#define NewFailureRecorder() \
[[ALPHAFailureRecorder alloc] initWithTestCase:self filePath:__FILE__ lineNumber:__LINE__]

@interface ALPHAFailureRecorder : NSObject

- (instancetype)initWithTestCase:(XCTestCase *)testCase filePath:(char const *)filePath lineNumber:(NSUInteger)lineNumber;

@property (nonatomic, readonly) XCTestCase *testCase;
@property (nonatomic, readonly, copy) NSString *filePath;
@property (nonatomic, readonly) NSUInteger lineNumber;

- (void)recordFailure:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

@end
