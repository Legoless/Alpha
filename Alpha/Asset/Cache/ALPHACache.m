//  ALPHACache is a modified version of ALPHACache
//  Modifications by Garrett Moon
//  Copyright © 2015 Pinterest. All rights reserved.

#import "ALPHACache.h"

NSString * const ALPHACachePrefix = @"com.unifiedsense.alpha.AssetCacheShared";
NSString * const ALPHACacheSharedName = @"ALPHAAssetCacheShared";

@interface ALPHACache ()
#if OS_OBJECT_USE_OBJC
@property (strong, nonatomic) dispatch_queue_t concurrentQueue;
#else
@property (assign, nonatomic) dispatch_queue_t concurrentQueue;
#endif
@end

@implementation ALPHACache

#pragma mark - Initialization -

#if !OS_OBJECT_USE_OBJC
- (void)dealloc
{
    dispatch_release(_concurrentQueue);
    _concurrentQueue = nil;
}
#endif

- (instancetype)init
{
    return [self initWithName:@"com.unifiedsense.Alpha"];
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name rootPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
}

- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath
{
    if (!name)
        return nil;
    
    if (self = [super init]) {
        _name = [name copy];
        
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@.%p", ALPHACachePrefix, self];
        _concurrentQueue = dispatch_queue_create([[NSString stringWithFormat:@"%@ Asynchronous Queue", queueName] UTF8String], DISPATCH_QUEUE_CONCURRENT);
        
        _diskCache = [[ALPHADiskCache alloc] initWithName:_name rootPath:rootPath];
        _memoryCache = [[ALPHAMemoryCache alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@.%@.%p", ALPHACachePrefix, _name, self];
}

+ (instancetype)sharedCache
{
    static id cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithName:ALPHACacheSharedName];
    });
    
    return cache;
}

#pragma mark - Public Asynchronous Methods -


- (void)objectForKey:(NSString *)key block:(ALPHACacheObjectBlock)block
{
    if (!key || !block)
        return;
    
    __weak ALPHACache *weakSelf = self;
    
    dispatch_async(_concurrentQueue, ^{
        ALPHACache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        __weak ALPHACache *weakSelf = strongSelf;
        
        [strongSelf->_memoryCache objectForKey:key block:^(ALPHAMemoryCache *cache, NSString *key, id object) {
            ALPHACache *strongSelf = weakSelf;
            if (!strongSelf)
                return;
            
            if (object) {
                [strongSelf->_diskCache fileURLForKey:key block:^(ALPHADiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
                    // update the access time on disk
                }];
                
                __weak ALPHACache *weakSelf = strongSelf;
                
                dispatch_async(strongSelf->_concurrentQueue, ^{
                    ALPHACache *strongSelf = weakSelf;
                    if (strongSelf)
                        block(strongSelf, key, object);
                });
            } else {
                __weak ALPHACache *weakSelf = strongSelf;
                
                [strongSelf->_diskCache objectForKey:key block:^(ALPHADiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
                    ALPHACache *strongSelf = weakSelf;
                    if (!strongSelf)
                        return;
                    
                    [strongSelf->_memoryCache setObject:object forKey:key block:nil];
                    
                    __weak ALPHACache *weakSelf = strongSelf;
                    
                    dispatch_async(strongSelf->_concurrentQueue, ^{
                        ALPHACache *strongSelf = weakSelf;
                        if (strongSelf)
                            block(strongSelf, key, object);
                    });
                }];
            }
        }];
    });
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key block:(ALPHACacheObjectBlock)block
{
    if (!key || !object)
        return;
    
    dispatch_group_t group = nil;
    ALPHAMemoryCacheObjectBlock memBlock = nil;
    ALPHADiskCacheObjectBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(ALPHAMemoryCache *cache, NSString *key, id object) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(ALPHADiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache setObject:object forKey:key block:memBlock];
    [_diskCache setObject:object forKey:key block:diskBlock];
    
    if (group) {
        __weak ALPHACache *weakSelf = self;
        dispatch_group_notify(group, _concurrentQueue, ^{
            ALPHACache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf, key, object);
        });
        
#if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
#endif
    }
}

- (void)removeObjectForKey:(NSString *)key block:(ALPHACacheObjectBlock)block
{
    if (!key)
        return;
    
    dispatch_group_t group = nil;
    ALPHAMemoryCacheObjectBlock memBlock = nil;
    ALPHADiskCacheObjectBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(ALPHAMemoryCache *cache, NSString *key, id object) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(ALPHADiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache removeObjectForKey:key block:memBlock];
    [_diskCache removeObjectForKey:key block:diskBlock];
    
    if (group) {
        __weak ALPHACache *weakSelf = self;
        dispatch_group_notify(group, _concurrentQueue, ^{
            ALPHACache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf, key, nil);
        });
        
#if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
#endif
    }
}

- (void)removeAllObjects:(ALPHACacheBlock)block
{
    dispatch_group_t group = nil;
    ALPHAMemoryCacheBlock memBlock = nil;
    ALPHADiskCacheBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(ALPHAMemoryCache *cache) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(ALPHADiskCache *cache) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache removeAllObjects:memBlock];
    [_diskCache removeAllObjects:diskBlock];
    
    if (group) {
        __weak ALPHACache *weakSelf = self;
        dispatch_group_notify(group, _concurrentQueue, ^{
            ALPHACache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf);
        });
        
#if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
#endif
    }
}

- (void)trimToDate:(NSDate *)date block:(ALPHACacheBlock)block
{
    if (!date)
        return;
    
    dispatch_group_t group = nil;
    ALPHAMemoryCacheBlock memBlock = nil;
    ALPHADiskCacheBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(ALPHAMemoryCache *cache) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(ALPHADiskCache *cache) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache trimToDate:date block:memBlock];
    [_diskCache trimToDate:date block:diskBlock];
    
    if (group) {
        __weak ALPHACache *weakSelf = self;
        dispatch_group_notify(group, _concurrentQueue, ^{
            ALPHACache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf);
        });
        
#if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
#endif
    }
}

#pragma mark - Public Synchronous Accessors -

- (NSUInteger)diskByteCount
{
    __block NSUInteger byteCount = 0;
    
    [_diskCache synchronouslyLockFileAccessWhileExecutingBlock:^(ALPHADiskCache *diskCache) {
        byteCount = diskCache.byteCount;
    }];
    
    return byteCount;
}

- (id)objectForKey:(NSString *)key
{
    if (!key)
        return nil;
    
    __block id object = nil;

    object = [_memoryCache objectForKey:key];
    
    if (object) {
        // update the access time on disk
        [_diskCache fileURLForKey:key block:NULL];
    } else {
        object = [_diskCache objectForKey:key];
        [_memoryCache setObject:object forKey:key];
    }
    
    return object;
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    if (!key || !object)
        return;
    
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
    if (!key)
        return;
    
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

- (void)trimToDate:(NSDate *)date
{
    if (!date)
        return;
    
    [_memoryCache trimToDate:date];
    [_diskCache trimToDate:date];
}

- (void)removeAllObjects
{
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjects];
}

@end
