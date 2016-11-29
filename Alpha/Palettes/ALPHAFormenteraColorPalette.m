//
//  ALPHAFormenteraColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

#import "ALPHAFormenteraColorPalette.h"

@implementation ALPHAFormenteraColorPalette

+ (instancetype)defaultPalette
{
    ALPHAFormenteraColorPalette *palette = [[ALPHAFormenteraColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = ALPHAColorFromKey(@"#07263B");
    palette.accentColor = ALPHAColorFromKey(@"#85E3EB");
    palette.backgroundColor = ALPHAColorFromKey(@"#07263B");
    palette.contentColor = ALPHAColorFromKey(@"#0B304A");
    palette.contentTintColor = ALPHAColorFromKey(@"#E5D947");
    palette.textColor = ALPHAColorFromKey(@"#95B3CB");
    
    return palette;
}

@end
