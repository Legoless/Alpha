//
//  ALPHAFormenteraColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHAFormenteraColorPalette.h"

@implementation ALPHAFormenteraColorPalette

+ (instancetype)defaultPalette
{
    ALPHAFormenteraColorPalette *palette = [[ALPHAFormenteraColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = UIColorFromKey(@"#E46A6B");
    palette.accentColor = UIColorFromKey(@"#3F3F3F");
    palette.backgroundColor = UIColorFromKey(@"#EEEEEE");
    palette.contentColor = [UIColor whiteColor];
    palette.textColor = UIColorFromKey(@"#040404");
    
    return palette;
}

@end
