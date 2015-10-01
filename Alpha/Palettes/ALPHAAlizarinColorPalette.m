//
//  ALPHAAlizarinColorPalette.m
//  Alpha
//
//  Created by Dal Rupnik on 20/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>
#import "ALPHAAlizarinColorPalette.h"

@implementation ALPHAAlizarinColorPalette

+ (instancetype)defaultPalette
{
    ALPHAAlizarinColorPalette *palette = [[ALPHAAlizarinColorPalette alloc] init];
    palette.headerFontFamily = @"GillSans";
    palette.headerFontSize = 14.0;
    palette.contentFontFamily = @"Menlo";
    palette.contentFontSize = 12.0;
    
    palette.mainColor = UIColorFromKey(@"#1B1F28");
    palette.accentColor = UIColorFromKey(@"#EA6573");
    palette.backgroundColor = UIColorFromKey(@"#1B1F28");
    palette.contentColor = UIColorFromKey(@"#30353A");
    palette.contentTintColor = UIColorFromKey(@"#EA6B76");
    palette.textColor = UIColorFromKey(@"#B3B6BD");
    
    return palette;
}

@end
