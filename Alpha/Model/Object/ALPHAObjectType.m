//
//  ALPHAObjectArgument.m
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"

@implementation ALPHAObjectType

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (NSString *)prettyDescription
{
    return self.name;
}

- (NSString *)typeString
{
    NSString* type = [self.name stringByReplacingOccurrencesOfString:@"*" withString:@""];
    type = [type stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return type;
}

@end
