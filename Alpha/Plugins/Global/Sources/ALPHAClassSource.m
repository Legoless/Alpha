//
//  ALPHAClassSource.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHATableScreenModel.h"

#import "ALPHARuntimeUtility.h"

#import "ALPHAClassSource.h"
#import "ALPHAObjectSource.h"

NSString* const ALPHAClassDataIdentifier = @"com.unifiedsense.alpha.data.class";
NSString* const ALPHAClassBinaryParameterKey = @"kALPHAClassBinaryParameterKey";

@interface ALPHAClassSource ()

@end

@implementation ALPHAClassSource

#pragma mark - Getters and Setters

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAClassDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    NSString* binaryImageName = [ALPHARuntimeUtility applicationImageName];
    
    if (request.parameters[ALPHAClassBinaryParameterKey])
    {
        binaryImageName = request.parameters[ALPHAClassBinaryParameterKey];
    }
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *classNames = [self classNamesForBinaryImageName:binaryImageName];
    
    for (NSString* class in classNames)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.title = class;
        
        ALPHARequest* request = [ALPHARequest requestForObject:NSClassFromString(class)];
        item.object = request;
        
        [items addObject:item];
    }
    
    //
    // Section & Model
    //
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAClassDataIdentifier];
    section.items = items.copy;
    
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAClassDataIdentifier];
    NSString *shortImageName = [[binaryImageName componentsSeparatedByString:@"/"] lastObject];
    model.title = [NSString stringWithFormat:@"%@ Classes (%lu)", shortImageName, (unsigned long)[classNames count]];;
    
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
