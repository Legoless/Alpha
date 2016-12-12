//
//  ALPHAToolDelegate.m
//  Alpha
//
//  Created by Dal Rupnik on 12/12/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "ALPHAToolDelegate.h"

#import "ALPHAManager.h"

@implementation ALPHAToolDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [ALPHAManager defaultManager].hidden = NO;
    });
    
    
    return YES;
}

@end
