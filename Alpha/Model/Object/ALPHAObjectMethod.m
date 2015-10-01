//
//  ALPHAObjectMethod.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectMethod.h"

@implementation ALPHAObjectMethod

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.returnType = [ALPHAObjectType new];
    }
    
    return self;
}

- (NSString *)prettyDescription
{
    NSString *selectorName = self.name;
    NSString *methodTypeString = self.isClassMethod ? @"+" : @"-";
    NSString *readableReturnType = self.returnType.name;
    NSString *prettyName = [NSString stringWithFormat:@"%@ (%@)", methodTypeString, readableReturnType];
    
    if ([self.arguments count] > 0)
    {
        NSMutableArray *prettyArguments = [NSMutableArray array];
        
        for (ALPHAObjectArgument *argument in self.arguments)
        {
            [prettyArguments addObject:argument.prettyDescription];
        }
        
        prettyName = [prettyName stringByAppendingString:[prettyArguments componentsJoinedByString:@" "]];
    }
    else
    {
        prettyName = [prettyName stringByAppendingString:selectorName];
    }
    
    return prettyName;

}

@end
