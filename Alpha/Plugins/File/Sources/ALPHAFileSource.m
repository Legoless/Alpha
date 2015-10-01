//
//  ALPHAFileSource.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"

#import "ALPHAFileModel.h"

#import "ALPHAFileSource.h"

NSString* const ALPHAFileDataIdentifier = @"com.unifiedsense.alpha.data.file";

@interface ALPHAFileSource ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation ALPHAFileSource

#pragma mark - Getters and Setters

- (NSFileManager *)fileManager
{
    if (!_fileManager)
    {
        _fileManager = [NSFileManager defaultManager];
    }
    
    return _fileManager;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAFileDataIdentifier];
    }
    
    return self;
}

#pragma mark - ALPHABaseDataSource

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    //
    // Get path
    //
    
    NSString *path = NSHomeDirectory();
    
    if (request.parameters[ALPHAFileURLParameterKey])
    {
        path = request.parameters[ALPHAFileURLParameterKey];
    }
    
    ALPHAFileModel* model = [[ALPHAFileModel alloc] initWithRequest:request];
    
    model.currentFile = [self fileObjectForPath:path];
    
    NSArray *contents = [self.fileManager contentsOfDirectoryAtPath:path error:NULL];
    
    if (contents)
    {
        NSMutableArray* items = [NSMutableArray array];
        
        for (NSString *fileName in contents)
        {
            [items addObject:[self fileObjectForPath:[path stringByAppendingPathComponent:fileName]]];
        }
        
        model.files = items.copy;
    }
    
    return model;
}

#pragma mark - Private methods

- (ALPHAFileObject *)fileObjectForPath:(NSString *)path;
{
    ALPHAFileObject *object = [[ALPHAFileObject alloc] init];
    object.path = path;
    
    NSDictionary *attributes = [self.fileManager attributesOfItemAtPath:path error:NULL];
    uint64_t totalSize = [attributes fileSize];
    
    NSUInteger count = 0;
    
    NSDirectoryEnumerator *enumerator = [self.fileManager enumeratorAtPath:path];
    
    if (enumerator)
    {
        for (NSString *fileName in enumerator)
        {
            attributes = [self.fileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:fileName] error:NULL];
            totalSize += [attributes fileSize];
            
            count++;
        }
    }
    
    BOOL isDirectory;
    
    [self.fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (isDirectory)
    {
        object.contents = @(count);
    }
    
    object.size = @(totalSize);
    object.modificationDate = [attributes fileModificationDate];
    
    //
    // Preview images
    //
    
    if ([ALPHARuntimeUtility isImagePathExtension:[path pathExtension]])
    {
        object.previewImage = [UIImage imageWithContentsOfFile:path];
    }
    
    return object;
}

@end
