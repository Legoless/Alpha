//
//  FLEXDarkTheme.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "ALPHADarkTheme.h"

@implementation ALPHADarkTheme

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.mainColor = [UIColor whiteColor];
        self.statusBarStyle = UIStatusBarStyleLightContent;
        
        self.disabledTitleColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        self.highlightedBackgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        self.selectedBackgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
    }
    
    return self;
}

@end