//
//  ALPHANotioColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"
#import "ALPHANotioColorPalette.h"

@implementation ALPHANotioColorPalette

+ (instancetype)defaultPalette
{
    ALPHANotioColorPalette *palette = [[ALPHANotioColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = ALPHAColorFromKey(@"#E46A6B");
    palette.accentColor = [UIColor whiteColor];
    palette.backgroundColor = ALPHAColorFromKey(@"#EEEEEE");
    palette.contentColor = [UIColor whiteColor];
    palette.contentTintColor = ALPHAColorFromKey(@"#6E6E6E");
    palette.textColor = ALPHAColorFromKey(@"#3F3F3F");
    
    return palette;
}

@end
