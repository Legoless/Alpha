//
//  UIApplication+Screenshot.h
//

@import UIKit;

@interface UIApplication (Screenshot)

- (UIImage *)screenshot;

- (UIImage *)screenshotExcludingWindows:(NSArray *)windows;

- (UIImage *)screenshotExcludingWindows:(NSArray *)windows withStatusBar:(BOOL)statusBar;

@end
