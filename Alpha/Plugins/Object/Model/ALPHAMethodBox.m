//
//  ALPHAMethodBox.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMethodBox.h"

@implementation ALPHAMethodBox

- (NSString *)prettyDescription
{
    NSString *selectorName = self.methodName;
    NSString *methodTypeString = self.isClassMethod ? @"+" : @"-";
    NSString *readableReturnType = self.methodReturnType;
    NSString *prettyName = [NSString stringWithFormat:@"%@ (%@)", methodTypeString, readableReturnType];
    
    if ([self.arguments count] > 0)
    {
        prettyName = [prettyName stringByAppendingString:[self.arguments componentsJoinedByString:@" "]];
    }
    else
    {
        prettyName = [prettyName stringByAppendingString:selectorName];
    }
    
    return prettyName;

}

@end
