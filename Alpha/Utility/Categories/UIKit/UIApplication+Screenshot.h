//
//  UIApplication+Screenshot.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import UIKit;

@interface UIApplication (Screenshot)

- (UIImage *)alpha_screenshot;

- (UIImage *)alpha_screenshotExcludingWindows:(NSArray *)windows;

- (UIImage *)alpha_screenshotExcludingWindows:(NSArray *)windows withStatusBar:(BOOL)statusBar;

@end
