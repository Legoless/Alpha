//
//  ALPHAConverterManager.m
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <objc/runtime.h>

#import "ALPHAConverterManager.h"
#import "ALPHAGenericConverter.h"

@interface ALPHAConverterManager ()

@property (nonatomic, strong) NSMutableOrderedSet *baseConverters;

/*!
 *  We keep a separate instance of generic converter which we use if we cannot find any other converter
 */
@property (nonatomic, strong) ALPHAGenericConverter *genericConverter;

@end

@implementation ALPHAConverterManager

- (NSMutableOrderedSet *)baseConverters
{
    if (!_baseConverters)
    {
        _baseConverters = [NSMutableOrderedSet orderedSet];
    }
    
    return _baseConverters;
}

- (ALPHAGenericConverter *)genericConverter
{
    if (!_genericConverter)
    {
        _genericConverter = [[ALPHAGenericConverter alloc] init];
    }
    
    return _genericConverter;
}

- (NSArray *)converterSources
{
    return self.baseConverters.array;
}

+ (instancetype)sharedManager
{
    static ALPHAConverterManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self loadConverters];
    }
    
    return self;
}

- (void)loadConverters
{
    //
    // Dynamically load all converters if they conform to protocol, so plugins do not have to
    // register those.
    //
    
    NSArray *converters = [self converterSourceClasses];
    
    for (Class class in converters)
    {
        [self registerConverterSource:[[class alloc] init]];
    }
}

- (void)registerConverterSource:(id<ALPHADataConverterSource>)converterSource;
{
    [self.baseConverters addObject:converterSource];
}

#pragma mark - ALPHADataConverterSource

- (BOOL)canConvertModel:(ALPHAModel *)model
{
    for (id<ALPHADataConverterSource> source in self.baseConverters)
    {
        if ([source canConvertModel:model])
        {
            return YES;
        }
    }
    
    return [self.genericConverter canConvertModel:model];
}

- (ALPHAScreenModel *)screenModelForModel:(ALPHAModel *)model
{
    for (id<ALPHADataConverterSource> source in self.baseConverters)
    {
        if ([source canConvertModel:model])
        {
            return [source screenModelForModel:model];
        }
    }
    
    return [self.genericConverter screenModelForModel:model];
}

#pragma mark - Private methods

- (NSArray *)converterSourceClasses
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
            
            if (class_conformsToProtocol(nextClass, @protocol(ALPHADataConverterSource)) && nextClass != [self class] && nextClass != [ALPHAGenericConverter class])
            {
                [sourceClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    
    return [sourceClasses copy];
}

@end
