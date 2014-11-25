//
//  KZBootstrap+FLEXUtilities.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "KZBootstrap+FLEXUtilities.h"

@implementation KZBootstrap (FLEXUtilities)

+ (BOOL)isReady
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"KZBEnvironments" withExtension:@"plist"];
    
    return (url != nil);
}

@end
