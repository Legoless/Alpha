//
//  FLEXThemeManager.h
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXTheme.h"

@interface FLEXThemeManager : NSObject

@property (nonatomic, strong) FLEXTheme *theme;

+ (instancetype)sharedManager;

@end
