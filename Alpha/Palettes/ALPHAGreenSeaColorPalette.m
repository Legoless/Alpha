//
//  ALPHAGreenSeaColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 20/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

#import "ALPHAGreenSeaColorPalette.h"

@implementation ALPHAGreenSeaColorPalette

+ (instancetype)defaultPalette
{
    ALPHAGreenSeaColorPalette *palette = [[ALPHAGreenSeaColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;

    palette.mainColor = ALPHAColorFromKey(@"#343842");
    palette.accentColor = ALPHAColorFromKey(@"#4CBA9C");
    palette.backgroundColor = ALPHAColorFromKey(@"#46535B");
    palette.contentColor = ALPHAColorFromKey(@"#464A55");
    palette.contentTintColor = ALPHAColorFromKey(@"#6BB9A6");
    palette.textColor = ALPHAColorFromKey(@"#FFFFFF");
    
    return palette;
}

@end
