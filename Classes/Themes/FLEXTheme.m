//
//  FLEXTheme.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXTheme.h"
#import "FLEXUtility.h"

@implementation FLEXTheme

- (NSDictionary *)titleAttributes
{
    return @{ NSFontAttributeName : [FLEXUtility defaultFontOfSize:12.0], NSForegroundColorAttributeName : self.defaultTitleColor };
}

- (CGFloat)topMargin
{
    return 2.0;
}

@end
