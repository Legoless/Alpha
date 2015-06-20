//
//  ALPHAGreenSeaColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 20/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHAGreenSeaColorPalette.h"

@implementation ALPHAGreenSeaColorPalette

+ (instancetype)defaultPalette
{
    ALPHAGreenSeaColorPalette *palette = [[ALPHAGreenSeaColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;

    palette.mainColor = UIColorFromKey(@"#343842");
    palette.accentColor = UIColorFromKey(@"#4CBA9C");
    palette.backgroundColor = UIColorFromKey(@"#46535B");
    palette.contentColor = UIColorFromKey(@"#464A55");
    palette.contentTintColor = UIColorFromKey(@"#6BB9A6");
    palette.textColor = UIColorFromKey(@"#FFFFFF");
    
    return palette;
}

@end
