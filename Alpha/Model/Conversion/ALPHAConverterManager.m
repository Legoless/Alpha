//
//  ALPHAConverterManager.m
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHAConverterManager.h"

@interface ALPHAConverterManager ()

@property (nonatomic, strong) NSMutableOrderedSet *baseConverters;

/*!
 *  We keep a separate instance of generic converter which we use if we cannot find any other converter
 */
@property (nonatomic, strong) id<ALPHADataConverterSource> genericConverter;

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

- (id<ALPHADataConverterSource>)genericConverter
{
    if (!_genericConverter)
    {
        Class genericConverterClass = NSClassFromString(@"ALPHAGenericConverter");
        
        if (genericConverterClass)
        {
            _genericConverter = [[genericConverterClass alloc] init];
        }
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

- (BOOL)canConvertObject:(id)object
{
    for (id<ALPHADataConverterSource> source in self.baseConverters)
    {
        if ([source canConvertObject:object])
        {
            return YES;
        }
    }
    
    return [self.genericConverter canConvertObject:object];
}

- (ALPHAScreenModel *)screenModelForObject:(id)object
{
    for (id<ALPHADataConverterSource> source in self.baseConverters)
    {
        if ([source canConvertObject:object])
        {
            return [source screenModelForObject:object];
        }
    }
    
    return [self.genericConverter screenModelForObject:object];
}

- (Class)renderClassForObject:(id)object
{
    if ([object isKindOfClass:[ALPHAScreenItem class]] && [object object])
    {
        return [self renderClassForObject:[(ALPHAScreenItem *)object object]];
    }
    
    for (id<ALPHADataConverterSource> source in self.baseConverters)
    {
        if ([source respondsToSelector:@selector(renderClassForObject:)])
        {
            Class class = [source renderClassForObject:object];
            
            if (class)
            {
                return class;
            }
        }
    }
    
    return [self.genericConverter renderClassForObject:object];
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
            
            if (class_conformsToProtocol(nextClass, @protocol(ALPHADataConverterSource)) && nextClass != [self class] && nextClass != NSClassFromString(@"ALPHAGenericConverter"))
            {
                [sourceClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    
    return [sourceClasses copy];
}

@end
