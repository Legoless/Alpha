//
//  ALPHAAssetManager.m
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHACache.h"

#import "ALPHAAssetManager.h"

@interface ALPHAAssetManager ()

@property (nonatomic, strong) NSMutableDictionary *assets;
@property (nonatomic, strong) ALPHACache *cache;

@end

@implementation ALPHAAssetManager

#pragma mark - Getters and Setters

- (ALPHACache *)cache
{
    if (!_cache)
    {
        _cache = [ALPHACache sharedCache];
    }
    
    return _cache;
}

- (NSMutableDictionary *)assets
{
    if (!_assets)
    {
        _assets = [NSMutableDictionary dictionary];
    }
    
    return _assets;
}

+ (instancetype)sharedManager
{
    static id sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self loadAssets];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)registerAsset:(ALPHAAsset *)asset
{
    NSAssert(asset.identifier.length > 0, @"Cannot register drawing block with identifier of zero length.");
    self.assets[asset.identifier] = asset;
}

- (UIImage *)imageWithIdentifier:(NSString *)identifier
{
    return [self imageWithIdentifier:identifier color:nil];
}

- (UIImage *)imageWithIdentifier:(NSString *)identifier color:(UIColor *)color
{
    return [self imageWithIdentifier:identifier color:color size:CGSizeZero];
}

- (UIImage *)imageWithIdentifier:(NSString *)identifier color:(UIColor *)color size:(CGSize)size
{
    return [self imageWithAsset:self.assets[identifier] color:color size:size];
}

- (UIImage *)imageWithAsset:(ALPHAAsset *)asset
{
    return [self imageWithAsset:asset color:nil];
}

- (UIImage *)imageWithAsset:(ALPHAAsset *)asset color:(UIColor *)color
{
    return [self imageWithAsset:asset color:color size:CGSizeZero];
}

- (UIImage *)imageWithAsset:(ALPHAAsset *)asset color:(UIColor *)color size:(CGSize)size
{
    //
    // Need asset to return image
    //
    
    if (!asset)
    {
        return nil;
    }
    
    //
    // Check if it is an asset image
    //
    
    if (asset.assetImage)
    {
        return [asset imageWithColor:color size:size];
    }
    
    //
    // Check size
    //
    
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        size = asset.drawingSize;
    }
    
    //
    // Check cache
    //
    
    UIImage *image = nil;
    NSString *cacheKey = nil;
    
    if (self.useCache)
    {
        cacheKey = [self cacheKeyForAsset:asset size:size color:color];
        
        image = [self.cache objectForKey:cacheKey];
        
        if (image)
        {
            return image;
        }
    }
    
    image = [asset imageWithColor:color size:size];
    
    if (self.useCache && cacheKey && image)
    {
        [self.cache setObject:image forKey:cacheKey];
    }
    
    return image;
}

- (NSString *)cacheKeyForAsset:(ALPHAAsset *)asset size:(CGSize)size color:(UIColor *)color
{
    NSMutableString *key = [NSMutableString stringWithString:asset.identifier];
    [key appendFormat:@"-%@", [NSStringFromCGSize(size) stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if (color)
    {
        [key appendString:[self colorStringForColor:color]];
    }
    
    return key.copy;
}

#pragma mark - Private methods

- (BOOL)useCache
{
    return NO;
}

- (void)loadAssets
{
    //
    // Dynamically load all converters if they conform to protocol, so plugins do not have to
    // register those.
    //
    
    NSArray *assets = [self assetClasses];
    
    for (Class class in assets)
    {
        [self registerAsset:[[class alloc] init]];
    }
}

- (NSArray *)assetClasses
{
    Class* classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    
    NSMutableArray *sourceClasses = [NSMutableArray array];
    
    if (numClasses > 0)
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        for (int index = 0; index < numClasses; index++)
        {
            Class nextClass = classes[index];
            
            if (class_getSuperclass(nextClass) == [ALPHAAsset class])
            {
                [sourceClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    
    return [sourceClasses copy];
}

- (NSString *)colorStringForColor:(UIColor *)color
{
    CGColorRef colorRef = color.CGColor;
    return [CIColor colorWithCGColor:colorRef].stringRepresentation;
}

@end
