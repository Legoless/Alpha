//  ALPHACache is a modified version of TMCache
//  Modifications by Garrett Moon
//  Copyright © 2015 Pinterest. All rights reserved.

#import "ALPHADiskCache.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
@import UIKit;
#endif

#define ALPHADiskCacheError(error) if (error) { NSLog(@"%@ (%d) ERROR: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, [error localizedDescription]); }

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0 && !defined(ALPHA_APP_EXTENSIONS)
#define ALPHACacheStartBackgroundTask() UIBackgroundTaskIdentifier taskID = UIBackgroundTaskInvalid; \
taskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{ \
[[UIApplication sharedApplication] endBackgroundTask:taskID]; }];
#define ALPHACacheEndBackgroundTask() [[UIApplication sharedApplication] endBackgroundTask:taskID];
#else
#define ALPHACacheStartBackgroundTask()
#define ALPHACacheEndBackgroundTask()
#endif

NSString * const ALPHADiskCachePrefix = @"com.unifiedsense.alpha.AssetCacheDisk";
NSString * const ALPHADiskCacheSharedName = @"ALPHADiskAssetCacheShared";

@interface ALPHADiskCache ()

@property (assign) NSUInteger byteCount;
@property (strong, nonatomic) NSURL *cacheURL;
#if OS_OBJECT_USE_OBJC
@property (strong, nonatomic) dispatch_queue_t asyncQueue;
@property (strong, nonatomic) dispatch_semaphore_t lockSemaphore;
#else
@property (assign, nonatomic) dispatch_queue_t asyncQueue;
@property (assign, nonatomic) dispatch_semaphore_t lockSemaphore;
#endif
@property (strong, nonatomic) NSMutableDictionary *dates;
@property (strong, nonatomic) NSMutableDictionary *sizes;
@end

@implementation ALPHADiskCache

@synthesize willAddObjectBlock = _willAddObjectBlock;
@synthesize willRemoveObjectBlock = _willRemoveObjectBlock;
@synthesize willRemoveAllObjectsBlock = _willRemoveAllObjectsBlock;
@synthesize didAddObjectBlock = _didAddObjectBlock;
@synthesize didRemoveObjectBlock = _didRemoveObjectBlock;
@synthesize didRemoveAllObjectsBlock = _didRemoveAllObjectsBlock;
@synthesize byteLimit = _byteLimit;
@synthesize ageLimit = _ageLimit;

#pragma mark - Initialization -

- (void)dealloc
{
#if !OS_OBJECT_USE_OBJC
    dispatch_release(_lockSemaphore);
    dispatch_release(_asyncQueue);
    _asyncQueue = nil;
#endif
}

- (instancetype)init
{
    return [self initWithName:@"com.unifiedsense.Alpha"];
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name rootPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
}

- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath
{
    if (!name)
        return nil;
    
    if (self = [super init]) {
        _name = [name copy];
        _asyncQueue = dispatch_queue_create([[NSString stringWithFormat:@"%@ Asynchronous Queue", ALPHADiskCachePrefix] UTF8String], DISPATCH_QUEUE_CONCURRENT);
        _lockSemaphore = dispatch_semaphore_create(1);
        _willAddObjectBlock = nil;
        _willRemoveObjectBlock = nil;
        _willRemoveAllObjectsBlock = nil;
        _didAddObjectBlock = nil;
        _didRemoveObjectBlock = nil;
        _didRemoveAllObjectsBlock = nil;
        
        _byteCount = 0;
        _byteLimit = 0;
        _ageLimit = 0.0;
        
        _dates = [[NSMutableDictionary alloc] init];
        _sizes = [[NSMutableDictionary alloc] init];
        
        NSString *pathComponent = [[NSString alloc] initWithFormat:@"%@.%@", ALPHADiskCachePrefix, _name];
        _cacheURL = [NSURL fileURLWithPathComponents:@[ rootPath, pathComponent ]];
        
        __weak ALPHADiskCache *weakSelf = self;
        dispatch_async(_asyncQueue, ^{
            ALPHADiskCache *strongSelf = weakSelf;
            [strongSelf lock];
                [strongSelf createCacheDirectory];
                [strongSelf initializeDiskProperties];
            [strongSelf unlock];
        });
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@.%@.%p", ALPHADiskCachePrefix, _name, self];
}

+ (instancetype)sharedCache
{
    static id cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithName:ALPHADiskCacheSharedName];
    });
    
    return cache;
}

#pragma mark - Private Methods -

- (NSURL *)encodedFileURLForKey:(NSString *)key
{
    if (![key length])
        return nil;
    
    return [_cacheURL URLByAppendingPathComponent:[self encodedString:key]];
}

- (NSString *)keyForEncodedFileURL:(NSURL *)url
{
    NSString *fileName = [url lastPathComponent];
    if (!fileName)
        return nil;
    
    return [self decodedString:fileName];
}

- (NSString *)encodedString:(NSString *)string
{
    if (![string length])
        return @"";
    
    CFStringRef static const charsToEscape = CFSTR(".:/");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)string,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)escapedString;
}

- (NSString *)decodedString:(NSString *)string
{
    if (![string length])
        return @"";
    
    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)string,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}

#pragma mark - Private Trash Methods -

+ (dispatch_queue_t)sharedTrashQueue
{
    static dispatch_queue_t trashQueue;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@.trash", ALPHADiskCachePrefix];
        trashQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(trashQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
    });
    
    return trashQueue;
}

+ (NSURL *)sharedTrashURL
{
    static NSURL *sharedTrashURL;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedTrashURL = [[[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:ALPHADiskCachePrefix isDirectory:YES];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[sharedTrashURL path]]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtURL:sharedTrashURL
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:&error];
            ALPHADiskCacheError(error);
        }
    });
    
    return sharedTrashURL;
}

+(BOOL)moveItemAtURLToTrash:(NSURL *)itemURL
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[itemURL path]])
        return NO;
    
    NSError *error = nil;
    NSString *uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];
    NSURL *uniqueTrashURL = [[ALPHADiskCache sharedTrashURL] URLByAppendingPathComponent:uniqueString];
    BOOL moved = [[NSFileManager defaultManager] moveItemAtURL:itemURL toURL:uniqueTrashURL error:&error];
    ALPHADiskCacheError(error);
    return moved;
}

+ (void)emptyTrash
{
    ALPHACacheStartBackgroundTask();
    
    dispatch_async([self sharedTrashQueue], ^{
        NSError *error = nil;
        NSArray *trashedItems = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[self sharedTrashURL]
                                                              includingPropertiesForKeys:nil
                                                                                 options:0
                                                                                   error:&error];
        ALPHADiskCacheError(error);
        
        for (NSURL *trashedItemURL in trashedItems) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtURL:trashedItemURL error:&error];
            ALPHADiskCacheError(error);
        }
        
        ALPHACacheEndBackgroundTask();
    });
}

#pragma mark - Private Queue Methods -

- (BOOL)createCacheDirectory
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[_cacheURL path]])
        return NO;
    
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtURL:_cacheURL
                                            withIntermediateDirectories:YES
                                                             attributes:nil
                                                                  error:&error];
    ALPHADiskCacheError(error);
    
    return success;
}

- (void)initializeDiskProperties
{
    NSUInteger byteCount = 0;
    NSArray *keys = @[ NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey ];
    
    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:_cacheURL
                                                   includingPropertiesForKeys:keys
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                        error:&error];
    ALPHADiskCacheError(error);
    
    for (NSURL *fileURL in files) {
        NSString *key = [self keyForEncodedFileURL:fileURL];
        
        error = nil;
        NSDictionary *dictionary = [fileURL resourceValuesForKeys:keys error:&error];
        ALPHADiskCacheError(error);
        
        NSDate *date = [dictionary objectForKey:NSURLContentModificationDateKey];
        if (date && key)
            [_dates setObject:date forKey:key];
        
        NSNumber *fileSize = [dictionary objectForKey:NSURLTotalFileAllocatedSizeKey];
        if (fileSize) {
            [_sizes setObject:fileSize forKey:key];
            byteCount += [fileSize unsignedIntegerValue];
        }
    }
    
    if (byteCount > 0)
        self.byteCount = byteCount; // atomic
}

- (BOOL)setFileModificationDate:(NSDate *)date forURL:(NSURL *)fileURL
{
    if (!date || !fileURL) {
        return NO;
    }
    
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] setAttributes:@{ NSFileModificationDate: date }
                                                    ofItemAtPath:[fileURL path]
                                                           error:&error];
    ALPHADiskCacheError(error);
    
    if (success) {
        NSString *key = [self keyForEncodedFileURL:fileURL];
        if (key) {
            [_dates setObject:date forKey:key];
        }
    }
    
    return success;
}

- (BOOL)removeFileAndExecuteBlocksForKey:(NSString *)key
{
    NSURL *fileURL = [self encodedFileURLForKey:key];
    if (!fileURL || ![[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]])
        return NO;
    
    if (_willRemoveObjectBlock)
        _willRemoveObjectBlock(self, key, nil, fileURL);
    
    BOOL trashed = [ALPHADiskCache moveItemAtURLToTrash:fileURL];
    if (!trashed)
        return NO;
    
    [ALPHADiskCache emptyTrash];
    
    NSNumber *byteSize = [_sizes objectForKey:key];
    if (byteSize)
        self.byteCount = _byteCount - [byteSize unsignedIntegerValue]; // atomic
    
    [_sizes removeObjectForKey:key];
    [_dates removeObjectForKey:key];
    
    if (_didRemoveObjectBlock)
        _didRemoveObjectBlock(self, key, nil, fileURL);
    
    return YES;
}

- (void)trimDiskToSize:(NSUInteger)trimByteCount
{
    if (_byteCount <= trimByteCount)
        return;
    
    NSArray *keysSortedBySize = [_sizes keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (NSString *key in [keysSortedBySize reverseObjectEnumerator]) { // largest objects first
        [self removeFileAndExecuteBlocksForKey:key];
        
        if (_byteCount <= trimByteCount)
            break;
    }
}

- (void)trimDiskToSizeByDate:(NSUInteger)trimByteCount
{
    if (_byteCount <= trimByteCount)
        return;
    
    NSArray *keysSortedByDate = [_dates keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (NSString *key in keysSortedByDate) { // oldest objects first
        [self removeFileAndExecuteBlocksForKey:key];
        
        if (_byteCount <= trimByteCount)
            break;
    }
}

- (void)trimDiskToDate:(NSDate *)trimDate
{
    NSArray *keysSortedByDate = [_dates keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (NSString *key in keysSortedByDate) { // oldest files first
        NSDate *accessDate = [_dates objectForKey:key];
        if (!accessDate)
            continue;
        
        if ([accessDate compare:trimDate] == NSOrderedAscending) { // older than trim date
            [self removeFileAndExecuteBlocksForKey:key];
        } else {
            break;
        }
    }
}

- (void)trimToAgeLimitRecursively
{
    [self lock];
        NSTimeInterval ageLimit = _ageLimit;
    [self unlock];
    if (ageLimit == 0.0)
        return;
    
    [self lock];
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:-ageLimit];
        [self trimDiskToDate:date];
    [self unlock];
    
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_ageLimit * NSEC_PER_SEC));
    dispatch_after(time, _asyncQueue, ^(void) {
        ALPHADiskCache *strongSelf = weakSelf;
        [strongSelf trimToAgeLimitRecursively];
    });
}

#pragma mark - Public Asynchronous Methods -

- (void)lockFileAccessWhileExecutingBlock:(void(^)(ALPHADiskCache *diskCache))block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (block) {
            [strongSelf lock];
                block(strongSelf);
            [strongSelf unlock];
        }
    });
}

- (void)objectForKey:(NSString *)key block:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        NSURL *fileURL = nil;
        id <NSCoding> object = [strongSelf objectForKey:key fileURL:&fileURL];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf, key, object, fileURL);
            [strongSelf unlock];
        }
    });
}

- (void)fileURLForKey:(NSString *)key block:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        NSURL *fileURL = [strongSelf fileURLForKey:key];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf, key, nil, fileURL);
            [strongSelf unlock];
        }
    });
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key block:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        NSURL *fileURL = nil;
        [strongSelf setObject:object forKey:key fileURL:&fileURL];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf, key, object, fileURL);
            [strongSelf unlock];
        }
    });
}

- (void)removeObjectForKey:(NSString *)key block:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        NSURL *fileURL = nil;
        [strongSelf removeObjectForKey:key fileURL:&fileURL];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf, key, nil, fileURL);
            [strongSelf unlock];
        }
    });
}

- (void)trimToSize:(NSUInteger)trimByteCount block:(ALPHADiskCacheBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        [strongSelf trimToSize:trimByteCount];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf);
            [strongSelf unlock];
        }
    });
}

- (void)trimToDate:(NSDate *)trimDate block:(ALPHADiskCacheBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        [strongSelf trimToDate:trimDate];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf);
            [strongSelf unlock];
        }
    });
}

- (void)trimToSizeByDate:(NSUInteger)trimByteCount block:(ALPHADiskCacheBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        [strongSelf trimToSizeByDate:trimByteCount];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf);
            [strongSelf unlock];
        }
    });
}

- (void)removeAllObjects:(ALPHADiskCacheBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        [strongSelf removeAllObjects];
        
        if (block) {
            [strongSelf lock];
                block(strongSelf);
            [strongSelf unlock];
        }
    });
}

- (void)enumerateObjectsWithBlock:(ALPHADiskCacheObjectBlock)block completionBlock:(ALPHADiskCacheBlock)completionBlock
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        [strongSelf enumerateObjectsWithBlock:block];
        
        if (completionBlock) {
            [self lock];
                completionBlock(strongSelf);
            [self unlock];
        }
    });
}

#pragma mark - Public Synchronous Methods -

- (void)synchronouslyLockFileAccessWhileExecutingBlock:(void(^)(ALPHADiskCache *diskCache))block
{
    if (block) {
        [self lock];
        block(self);
        [self unlock];
    }
}

- (id <NSCoding>)objectForKey:(NSString *)key
{
    return [self objectForKey:key fileURL:nil];
}

- (id <NSCoding>)objectForKey:(NSString *)key fileURL:(NSURL **)outFileURL
{
    NSDate *now = [[NSDate alloc] init];
    
    if (!key)
        return nil;
    
    id <NSCoding> object = nil;
    NSURL *fileURL = nil;
    
    [self lock];
        fileURL = [self encodedFileURLForKey:key];
        object = nil;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
            @try {
                object = [NSKeyedUnarchiver unarchiveObjectWithFile:[fileURL path]];
            }
            @catch (NSException *exception) {
                NSError *error = nil;
                [[NSFileManager defaultManager] removeItemAtPath:[fileURL path] error:&error];
                ALPHADiskCacheError(error);
            }
            
            [self setFileModificationDate:now forURL:fileURL];
        }
    [self unlock];
    
    if (outFileURL) {
        *outFileURL = fileURL;
    }
    
    return object;
}

- (NSURL *)fileURLForKey:(NSString *)key
{
    NSDate *now = [[NSDate alloc] init];
    
    if (!key)
        return nil;
    
    NSURL *fileURL = nil;
    
    [self lock];
        fileURL = [self encodedFileURLForKey:key];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
            [self setFileModificationDate:now forURL:fileURL];
        } else {
            fileURL = nil;
        }
    [self unlock];
    return fileURL;
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [self setObject:object forKey:key fileURL:nil];
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key fileURL:(NSURL **)outFileURL
{
    NSDate *now = [[NSDate alloc] init];
    
    if (!key || !object)
        return;
    
    ALPHACacheStartBackgroundTask();
    
    NSURL *fileURL = nil;
    
    [self lock];
        fileURL = [self encodedFileURLForKey:key];
        
        if (self->_willAddObjectBlock)
            self->_willAddObjectBlock(self, key, object, fileURL);
        
        BOOL written = [NSKeyedArchiver archiveRootObject:object toFile:[fileURL path]];
        
        if (written) {
            [self setFileModificationDate:now forURL:fileURL];
            
            NSError *error = nil;
            NSDictionary *values = [fileURL resourceValuesForKeys:@[ NSURLTotalFileAllocatedSizeKey ] error:&error];
            ALPHADiskCacheError(error);
            
            NSNumber *diskFileSize = [values objectForKey:NSURLTotalFileAllocatedSizeKey];
            if (diskFileSize) {
                [self->_sizes setObject:diskFileSize forKey:key];
                self.byteCount = self->_byteCount + [diskFileSize unsignedIntegerValue]; // atomic
            }
            
            if (self->_byteLimit > 0 && self->_byteCount > self->_byteLimit)
                [self trimToSizeByDate:self->_byteLimit block:nil];
        } else {
            fileURL = nil;
        }
        
        if (self->_didAddObjectBlock)
            self->_didAddObjectBlock(self, key, object, written ? fileURL : nil);
    [self unlock];
    
    if (outFileURL) {
        *outFileURL = fileURL;
    }
    
    ALPHACacheEndBackgroundTask();
}

- (void)removeObjectForKey:(NSString *)key
{
    [self removeObjectForKey:key fileURL:nil];
}

- (void)removeObjectForKey:(NSString *)key fileURL:(NSURL **)outFileURL
{
    if (!key)
        return;
    
    ALPHACacheStartBackgroundTask();
    
    NSURL *fileURL = nil;
    
    [self lock];
        fileURL = [self encodedFileURLForKey:key];
        [self removeFileAndExecuteBlocksForKey:key];
    [self unlock];
    
    ALPHACacheEndBackgroundTask();
    
    if (outFileURL) {
        *outFileURL = fileURL;
    }
}

- (void)trimToSize:(NSUInteger)trimByteCount
{
    if (trimByteCount == 0) {
        [self removeAllObjects];
        return;
    }
    
    ALPHACacheStartBackgroundTask();
    
    [self lock];
        [self trimDiskToSize:trimByteCount];
    [self unlock];
    
    ALPHACacheEndBackgroundTask();
}

- (void)trimToDate:(NSDate *)trimDate
{
    if (!trimDate)
        return;
    
    if ([trimDate isEqualToDate:[NSDate distantPast]]) {
        [self removeAllObjects];
        return;
    }
    
    ALPHACacheStartBackgroundTask();
    
    [self lock];
        [self trimDiskToDate:trimDate];
    [self unlock];
    
    ALPHACacheEndBackgroundTask();
}

- (void)trimToSizeByDate:(NSUInteger)trimByteCount
{
    if (trimByteCount == 0) {
        [self removeAllObjects];
        return;
    }
    
    ALPHACacheStartBackgroundTask();
    
    [self lock];
        [self trimDiskToSizeByDate:trimByteCount];
    [self unlock];
    
    ALPHACacheEndBackgroundTask();
}

- (void)removeAllObjects
{
    ALPHACacheStartBackgroundTask();
    
    [self lock];
        if (self->_willRemoveAllObjectsBlock)
            self->_willRemoveAllObjectsBlock(self);
        
        [ALPHADiskCache moveItemAtURLToTrash:self->_cacheURL];
        [ALPHADiskCache emptyTrash];
        
        [self createCacheDirectory];
        
        [self->_dates removeAllObjects];
        [self->_sizes removeAllObjects];
        self.byteCount = 0; // atomic
        
        if (self->_didRemoveAllObjectsBlock)
            self->_didRemoveAllObjectsBlock(self);
    [self unlock];
    
    ALPHACacheEndBackgroundTask();
}

- (void)enumerateObjectsWithBlock:(ALPHADiskCacheObjectBlock)block
{
    if (!block)
        return;
    
    ALPHACacheStartBackgroundTask();
    
    [self lock];
        NSArray *keysSortedByDate = [self->_dates keysSortedByValueUsingSelector:@selector(compare:)];
        
        for (NSString *key in keysSortedByDate) {
            NSURL *fileURL = [self encodedFileURLForKey:key];
            block(self, key, nil, fileURL);
        }
    [self unlock];
    
    ALPHACacheEndBackgroundTask();
}

#pragma mark - Public Thread Safe Accessors -

- (ALPHADiskCacheObjectBlock)willAddObjectBlock
{
    ALPHADiskCacheObjectBlock block = nil;
    
    [self lock];
        block = _willAddObjectBlock;
    [self unlock];
    
    return block;
}

- (void)setWillAddObjectBlock:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        [strongSelf lock];
            strongSelf->_willAddObjectBlock = [block copy];
        [strongSelf unlock];
    });
}

- (ALPHADiskCacheObjectBlock)willRemoveObjectBlock
{
    ALPHADiskCacheObjectBlock block = nil;
    
    [self lock];
        block = _willRemoveObjectBlock;
    [self unlock];
    
    return block;
}

- (void)setWillRemoveObjectBlock:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
            strongSelf->_willRemoveObjectBlock = [block copy];
        [strongSelf unlock];
    });
}

- (ALPHADiskCacheBlock)willRemoveAllObjectsBlock
{
    ALPHADiskCacheBlock block = nil;
    
    [self lock];
        block = _willRemoveAllObjectsBlock;
    [self unlock];
    
    return block;
}

- (void)setWillRemoveAllObjectsBlock:(ALPHADiskCacheBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
            strongSelf->_willRemoveAllObjectsBlock = [block copy];
        [strongSelf unlock];
    });
}

- (ALPHADiskCacheObjectBlock)didAddObjectBlock
{
    ALPHADiskCacheObjectBlock block = nil;
    
    [self lock];
        block = _didAddObjectBlock;
    [self unlock];
    
    return block;
}

- (void)setDidAddObjectBlock:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
            strongSelf->_didAddObjectBlock = [block copy];
        [strongSelf unlock];
    });
}

- (ALPHADiskCacheObjectBlock)didRemoveObjectBlock
{
    ALPHADiskCacheObjectBlock block = nil;
    
    [self lock];
        block = _didRemoveObjectBlock;
    [self unlock];
    
    return block;
}

- (void)setDidRemoveObjectBlock:(ALPHADiskCacheObjectBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
            strongSelf->_didRemoveObjectBlock = [block copy];
        [strongSelf unlock];
    });
}

- (ALPHADiskCacheBlock)didRemoveAllObjectsBlock
{
    ALPHADiskCacheBlock block = nil;
    
    [self lock];
        block = _didRemoveAllObjectsBlock;
    [self unlock];
    
    return block;
}

- (void)setDidRemoveAllObjectsBlock:(ALPHADiskCacheBlock)block
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
            strongSelf->_didRemoveAllObjectsBlock = [block copy];
        [strongSelf unlock];
    });
}

- (NSUInteger)byteLimit
{
    NSUInteger byteLimit;
    
    [self lock];
        byteLimit = _byteLimit;
    [self unlock];
    
    return byteLimit;
}

- (void)setByteLimit:(NSUInteger)byteLimit
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
        strongSelf->_byteLimit = byteLimit;
        
        if (byteLimit > 0)
            [strongSelf trimDiskToSizeByDate:byteLimit];
        [strongSelf unlock];
    });
}

- (NSTimeInterval)ageLimit
{
    NSTimeInterval ageLimit;
    
    [self lock];
        ageLimit = _ageLimit;
    [self unlock];
    
    return ageLimit;
}

- (void)setAgeLimit:(NSTimeInterval)ageLimit
{
    __weak ALPHADiskCache *weakSelf = self;
    
    dispatch_async(_asyncQueue, ^{
        ALPHADiskCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        [strongSelf lock];
            strongSelf->_ageLimit = ageLimit;
        [strongSelf unlock];
        
        [strongSelf trimToAgeLimitRecursively];
    });
}

- (void)lock
{
    dispatch_semaphore_wait(_lockSemaphore, DISPATCH_TIME_FOREVER);
}

- (void)unlock
{
    dispatch_semaphore_signal(_lockSemaphore);
}

@end
