//
//  ALPHAAmethystColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 20/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHAAmethystColorPalette.h"

@implementation ALPHAAmethystColorPalette

+ (instancetype)defaultPalette
{
    ALPHAAmethystColorPalette *palette = [[ALPHAAmethystColorPalette alloc] init];
    
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = UIColorFromKey(@"#968187");
    palette.accentColor = UIColorFromKey(@"#FFF6F4");
    palette.backgroundColor = UIColorFromKey(@"#BFB5BE");
    palette.contentColor = UIColorFromKey(@"#A69BA9");
    palette.contentTintColor = UIColorFromKey(@"#34373F");
    palette.textColor = UIColorFromKey(@"#5A5C68");
    
    return palette;
}

@end
