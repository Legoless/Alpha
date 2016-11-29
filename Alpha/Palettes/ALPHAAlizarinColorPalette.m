//
//  ALPHAAlizarinColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 20/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"
#import "ALPHAAlizarinColorPalette.h"

@implementation ALPHAAlizarinColorPalette

+ (instancetype)defaultPalette
{
    ALPHAAlizarinColorPalette *palette = [[ALPHAAlizarinColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = ALPHAColorFromKey(@"#1B1F28");
    palette.accentColor = ALPHAColorFromKey(@"#EA6573");
    palette.backgroundColor = ALPHAColorFromKey(@"#1B1F28");
    palette.contentColor = ALPHAColorFromKey(@"#30353A");
    palette.contentTintColor = ALPHAColorFromKey(@"#EA6B76");
    palette.textColor = ALPHAColorFromKey(@"#B3B6BD");
    
    return palette;
}

@end
