//
//  ALPHAFailureRecorder.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFailureRecorder.h"

@interface ALPHAFailureRecorder ()

@property (nonatomic, readwrite) XCTestCase *testCase;
@property (nonatomic, readwrite, copy) NSString *filePath;
@property (nonatomic, readwrite) NSUInteger lineNumber;

@end

@implementation ALPHAFailureRecorder

- (instancetype)initWithTestCase:(XCTestCase *)testCase filePath:(const char *)filePath lineNumber:(NSUInteger)lineNumber
{
    self = [super init];
    
    if (self)
    {
        self.testCase = testCase;
        self.filePath = [NSString stringWithUTF8String:filePath];
        self.lineNumber = lineNumber;
    }
    
    return self;
}

- (void)recordFailure:(NSString *)format, ...;
{
    va_list ap;
    va_start(ap, format);
    NSString *d = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    [self.testCase recordFailureWithDescription:d inFile:self.filePath atLine:self.lineNumber expected:YES];
}

@end
