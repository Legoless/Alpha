//
//  FLEXLightTheme.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "ALPHAUtility.h"
#import "ALPHALightTheme.h"

@implementation ALPHALightTheme

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.mainColor = [UIColor blackColor];
        
        /*
        self.disabledTitleColor = [UIColor colorWithWhite:121.0/255.0 alpha:1.0];
        self.highlightedBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        self.selectedBackgroundColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];*/
    }
    
    return self;
}

@end