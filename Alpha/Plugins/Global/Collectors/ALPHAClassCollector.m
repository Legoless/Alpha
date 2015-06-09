//
//  ALPHAClassCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <objc/runtime.h>

#import "ALPHATableScreenModel.h"

#import "FLEXUtility.h"

#import "ALPHAClassCollector.h"

NSString* const ALPHAClassDataIdentifier = @"com.unifiedsense.alpha.data.class";

@interface ALPHAClassCollector ()

@property (nonatomic, copy) NSArray *classNames;
@property (nonatomic, copy) NSString *binaryImageName;

@end


@implementation ALPHAClassCollector

#pragma mark - Getters and Setters

- (void)setBinaryImageName:(NSString *)binaryImageName
{
    if (![_binaryImageName isEqual:binaryImageName])
    {
        _binaryImageName = binaryImageName;
        
        self.classNames = [self classNamesForBinaryImageName:binaryImageName];
    }
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAClassDataIdentifier];
        
        self.binaryImageName = [FLEXUtility applicationImageName];
    }
    
    return self;
}

- (ALPHAModel *)model
{
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSString* class in self.classNames)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.title = class;
        item.object = NSClassFromString(class);
        
        [items addObject:item];
    }
    
    //
    // Section & Model
    //
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAClassDataIdentifier];
    section.items = items.copy;
    
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAClassDataIdentifier];
    NSString *shortImageName = [[self.binaryImageName componentsSeparatedByString:@"/"] lastObject];
    model.title = [NSString stringWithFormat:@"%@ Classes (%lu)", shortImageName, (unsigned long)[self.classNames count]];;
    
    model.sections = @[ section ];
    
    return model;
}

#pragma mark - Private Methods

- (NSArray *)classNamesForBinaryImageName:(NSString *)binaryImageName
{
    unsigned int classNamesCount = 0;
    const char **classNames = objc_copyClassNamesForImage([binaryImageName UTF8String], &classNamesCount);
    
    if (classNames)
    {
        NSMutableArray *classNameStrings = [NSMutableArray array];
        for (unsigned int i = 0; i < classNamesCount; i++) {
            const char *className = classNames[i];
            NSString *classNameString = [NSString stringWithUTF8String:className];
            [classNameStrings addObject:classNameString];
        }
        
        free(classNames);
        
        return [classNameStrings sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    }
    
    return nil;
}

@end
