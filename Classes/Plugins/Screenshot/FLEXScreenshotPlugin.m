//
//  FLEXScreenshotPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "FLEXWindow.h"
#import "FLEXResources.h"
#import "FLEXFileManager.h"

#import "FLEXScreenshotPlugin.h"

@interface FLEXScreenshotPlugin ()

@property (nonatomic, strong) NSDateFormatter* fileDateFormatter;

@end

@implementation FLEXScreenshotPlugin

- (NSDateFormatter *)fileDateFormatter
{
    if (!_fileDateFormatter)
    {
        _fileDateFormatter = [[NSDateFormatter alloc] init];
        _fileDateFormatter.dateFormat = @"yyyy.MM.dd_HH.mm.ss";
    }
    
    return _fileDateFormatter;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        FLEXActionItem *touchAction = [FLEXActionItem actionItemWithIdentifier:@"com.flex.screenshot.make"];
        touchAction.title = @"Screenshot";
        touchAction.image = [FLEXResources dragHandle];
        touchAction.action = ^(id sender){
            [self saveScreenshot];
        };
        touchAction.enabled = YES;
        
        [self registerAction:touchAction];
        
    }
    
    return self;
}

- (void)saveScreenshot
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    NSMutableArray *excludedWindows = [NSMutableArray array];
    
    for (UIWindow *window in windows)
    {
        if ([window isKindOfClass:[FLEXWindow class]])
        {
            [excludedWindows addObject:window];
        }
    }
    
    UIImage *screenshot = [[UIApplication sharedApplication] screenshotExcludingWindows:excludedWindows ];
    
    [self saveImage:screenshot];
}

- (void)saveImage:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *directory = [NSString stringWithFormat:@"%@FLEX/Screenshots", [[FLEXFileManager sharedManager] documentsDirectory].absoluteString];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", directory, [self stringForFile]];
    
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
    }
}

- (NSString *)stringForFile
{
    return [NSString stringWithFormat:@"FLEX_SS_%@.png", [self.fileDateFormatter stringFromDate:[NSDate date]]];
}

@end
