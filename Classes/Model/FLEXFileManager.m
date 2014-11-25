//
//  FLEXFileManager.m
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXFileManager.h"

@implementation FLEXFileManager

- (NSDateFormatter *)fileDateFormatter
{
    if (!_fileDateFormatter)
    {
        _fileDateFormatter = [[NSDateFormatter alloc] init];
        _fileDateFormatter.dateFormat = @"yyyy.MM.dd_HH.mm.ss";
    }
    
    return _fileDateFormatter;
}

#pragma mark - Singleton

+ (instancetype)sharedManager
{
    static FLEXFileManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

/*!
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
