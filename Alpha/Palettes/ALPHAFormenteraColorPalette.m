//
//  ALPHAFormenteraColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 19/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
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
    
    palette.mainColor = UIColorFromKey(@"#07263B");
    palette.accentColor = UIColorFromKey(@"#85E3EB");
    palette.backgroundColor = UIColorFromKey(@"#07263B");
    palette.contentColor = UIColorFromKey(@"#0B304A");
    palette.contentTintColor = UIColorFromKey(@"#E5D947");
    palette.textColor = UIColorFromKey(@"#95B3CB");
    
    return palette;
}

@end
