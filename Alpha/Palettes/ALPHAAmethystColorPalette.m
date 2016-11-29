//
//  ALPHAAmethystColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 20/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

#import "ALPHAAmethystColorPalette.h"

@implementation ALPHAAmethystColorPalette

+ (instancetype)defaultPalette
{
    ALPHAAmethystColorPalette *palette = [[ALPHAAmethystColorPalette alloc] init];
    
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = ALPHAColorFromKey(@"#968187");
    palette.accentColor = ALPHAColorFromKey(@"#FFF6F4");
    palette.backgroundColor = ALPHAColorFromKey(@"#BFB5BE");
    palette.contentColor = ALPHAColorFromKey(@"#A69BA9");
    palette.contentTintColor = ALPHAColorFromKey(@"#34373F");
    palette.textColor = ALPHAColorFromKey(@"#5A5C68");
    
    return palette;
}

@end
