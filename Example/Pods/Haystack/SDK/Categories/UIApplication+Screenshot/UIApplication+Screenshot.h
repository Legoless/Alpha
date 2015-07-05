//
//  UIApplication+Screenshot.h
//

@import UIKit;

@interface UIApplication (Screenshot)

- (UIImage *)hay_screenshot;

- (UIImage *)hay_screenshotExcludingWindows:(NSArray *)windows;

- (UIImage *)hay_screenshotExcludingWindows:(NSArray *)windows withStatusBar:(BOOL)statusBar;

@end
