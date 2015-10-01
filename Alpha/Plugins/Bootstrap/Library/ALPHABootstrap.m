//
//  ALPHABootstrap.h
//  Alpha
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHABootstrap.h"

@implementation ALPHABootstrap

+ (BOOL)hasEnvironments
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"KZBEnvironments" withExtension:@"plist"];
    
    return (url != nil);
}

@end
