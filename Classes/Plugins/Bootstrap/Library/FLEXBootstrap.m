//
//  FLEXBootstrap.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXBootstrap.h"

@implementation FLEXBootstrap

+ (BOOL)isReady
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"KZBEnvironments" withExtension:@"plist"];
    
    return (url != nil);
}

@end
