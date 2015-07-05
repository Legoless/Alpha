//
//  UIApplication+Screenshot.m
//

#import "UIView+Snapshot.h"

#import "UIApplication+Screenshot.h"

@import UIKit;

@implementation UIApplication (Screenshot)

- (UIImage *)hay_screenshot
{
    return [self hay_screenshotExcludingWindows:nil withStatusBar:YES];
}

- (UIImage *)hay_screenshotExcludingWindows:(NSArray *)windows
{
    return [self hay_screenshotExcludingWindows:windows withStatusBar:YES];
}

- (UIImage *)hay_screenshotExcludingWindows:(NSArray *)windows withStatusBar:(BOOL)statusBar
{
    NSMutableArray* sourceWindows = [self.windows mutableCopy];
    
    if (windows.count)
    {
        [sourceWindows removeObjectsInArray:windows];
    }
    
    if (statusBar && [self statusBarView])
    {
        [sourceWindows addObject:[self statusBarView]];
    }
    
    return [self imageByCombiningImages:[self imagesFromViews:sourceWindows]];
}

- (NSArray *)imagesFromViews:(NSArray *)views
{
    NSMutableArray* images = [NSMutableArray array];
    
    for (UIView *view in views)
    {
        [images addObject:[view hay_snapshotImageWithScale:2.0]];
    }
    
    return [images copy];
}

- (UIImage *)imageByCombiningImages:(NSArray *)images
{
    UIImage *finalImage = nil;
    
    //
    // Find Max size
    //
    
    CGSize newImageSize = CGSizeZero;
    
    for (UIImage *image in images)
    {
        if (image.size.width > newImageSize.width)
        {
            newImageSize.width = image.size.width;
        }
        
        if (image.size.height > newImageSize.height)
        {
            newImageSize.height = image.size.height;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(newImageSize, NO, [[UIScreen mainScreen] scale]);
    
    for (UIImage *image in images)
    {
        [image drawInRect:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    }
    
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return finalImage;
}

/**
 *  Private method returns status bar view
 *
 *  @return status bar view
 */
- (UIView *)statusBarView
{
    NSString *key = [[NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9] encoding:NSASCIIStringEncoding];
    
    id object = self;
    
    UIView *statusBar = nil;
    
    if ([object respondsToSelector:NSSelectorFromString(key)])
    {
        statusBar = [object valueForKey:key];
    }
    
    return statusBar;
}

@end