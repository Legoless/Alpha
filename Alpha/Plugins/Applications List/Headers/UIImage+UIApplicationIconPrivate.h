@class UIImage;
@interface UIImage (UIApplicationIconPrivate)
/*
 @param format
 0 - 29x29
 1 - 40x40
 2 - 62x62
 3 - 42x42
 4 - 37x48
 5 - 37x48
 6 - 82x82
 7 - 62x62
 8 - 20x20
 9 - 37x48
 10 - 37x48
 11 - 122x122
 12 - 58x58
 */
+ (UIImage *)_applicationIconImageForBundleIdentifier:(NSString *)bundleIdentifier format:(int)format;
@end