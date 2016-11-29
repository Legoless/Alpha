//
//  ALPHAScreenshotPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "UIApplication+Screenshot.h"

#import "ALPHAWindow.h"
#import "ALPHAFileManager.h"
#import "ALPHAScreenshotSource.h"
#import "ALPHAActions.h"

#import "ALPHAScreenshotIcon.h"
#import "ALPHAAssetManager.h"

#import "ALPHAManager.h"

#import "ALPHAScreenshotPlugin.h"

@interface ALPHAScreenshotPlugin ()

@end

@implementation ALPHAScreenshotPlugin

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.screenshot"];
    
    if (self)
    {
        ALPHABlockActionItem *touchAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.screenshot.make"];
        touchAction.title = @"Screenshot";
        touchAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconScreenshotIdentifier color:nil size:CGSizeMake(28.0, 28.0)];
        touchAction.priority = 2000.0;
        touchAction.actionBlock = ^id(id sender)
        {
            [self saveScreenshot];
            
            return nil;
        };
        
        [self registerAction:touchAction];
        
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.screenshot.main"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconScreenshotIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Screenshots";
        menuAction.dataIdentifier = ALPHAScreenshotDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        [self registerSource:[ALPHAScreenshotSource new]];
    }
    
    return self;
}

- (void)saveScreenshot
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    NSMutableArray *excludedWindows = [NSMutableArray array];
    
    for (UIWindow *window in windows)
    {
        if ([window isKindOfClass:[ALPHAWindow class]])
        {
            [excludedWindows addObject:window];
        }
    }
    
    UIImage *screenshot = [[UIApplication sharedApplication] alpha_screenshotExcludingWindows:excludedWindows];
    
    [self saveImage:screenshot];
}

- (void)saveImage:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *directory = [NSString stringWithFormat:@"%@Alpha/Screenshots", [[ALPHAFileManager sharedManager] documentsDirectory].absoluteString];
    
    NSString *filename = [self stringForFile];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", directory, filename];
    
    NSURL *fileURL = [NSURL URLWithString:filePath];
    
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:&isDir];
    
    if (!exists || !isDir)
    {
        NSError *error;
        
        [[NSFileManager defaultManager] createDirectoryAtURL:[NSURL URLWithString:directory] withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSError* error;
        [imageData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        
        [[ALPHAManager defaultManager] displayNotificationWithMessage:[NSString stringWithFormat:@"Screenshot taken: %@", filename] forDuration:1.5];
    }
}

- (NSString *)stringForFile
{
    return [NSString stringWithFormat:@"ALPHA_SS_%@.png", [[ALPHAFileManager sharedManager].fileDateFormatter stringFromDate:[NSDate date]]];
}

@end
