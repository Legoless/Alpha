//
//  ALPHANotioColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHANotioColorPalette.h"

@implementation ALPHANotioColorPalette

+ (instancetype)defaultPalette
{
    ALPHANotioColorPalette *palette = [[ALPHANotioColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = UIColorFromKey(@"#E46A6B");
    palette.accentColor = [UIColor whiteColor];
    palette.backgroundColor = UIColorFromKey(@"#EEEEEE");
    palette.contentColor = [UIColor whiteColor];
    palette.contentTintColor = UIColorFromKey(@"#6E6E6E");
    palette.textColor = UIColorFromKey(@"#3F3F3F");
    
    return palette;
}

@end
