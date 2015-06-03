//
//  ALPHAGenericConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "ALPHAGenericConverter.h"
#import "ALPHAGenericModel.h"

@implementation ALPHAGenericConverter

- (BOOL)canConvertModel:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHAModel class]];
}

- (ALPHAScreenModel *)screenModelForModel:(ALPHAModel *)model
{
    //
    // Heuristics to use data property in generic model
    //
    
    if ([model isKindOfClass:[ALPHAGenericModel class]])
    {
        return [self convertGenericModel:(ALPHAGenericModel *)model];
    }
    
    //
    // Attempt to convert to screen model using class info
    //
    
    return [self convertCustomModel:model];
}

- (ALPHAScreenModel *)convertGenericModel:(ALPHAGenericModel *)model
{
    ALPHAScreenModel* screenModel = [[ALPHAScreenModel alloc] initWithIdentifier:model.identifier];
    screenModel.title = model.data[@"title"];
    
    if ([model.data[@"items"] isKindOfClass:[NSArray class]])
    {
        //
        // If model has items, we create a single section
        //
        
        NSMutableDictionary* dictionary = [model.data mutableCopy];
        
        // Title belongs to the screen, not using it for section
        [dictionary removeObjectForKey:@"title"];
        
        ALPHAScreenSection* section = [ALPHAScreenSection screenSectionWithDictionary:dictionary];
        
        screenModel.sections = @[ section ];
    }
    else if ([model.data[@"sections"] isKindOfClass:[NSArray class]])
    {
        NSMutableArray* sections = [NSMutableArray array];
        
        for (id object in model.data[@"sections"])
        {
            ALPHAScreenSection* section = [ALPHAScreenSection screenSectionWithDictionary:object];
            
            if (section)
            {
                [sections addObject:section];
            }
        }
        
        screenModel.sections = sections.copy;
    }
    
    return screenModel;
}

#pragma mark - Custom model conversion

- (ALPHAScreenModel *)convertCustomModel:(ALPHAModel *)model
{
    //
    // Each array property of the model will be a section, model class will be the title of the screen,
    // other properties will be placed in a single section
    //
    
    ALPHAScreenModel* screenModel = [[ALPHAScreenModel alloc] initWithIdentifier:model.identifier];
    screenModel.title = [self cleanCodeIdentifierString:NSStringFromClass([model class])];
    
    ALPHAScreenSection* mainSection = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* sections = [NSMutableArray array];
    NSMutableArray* items = [NSMutableArray array];
    
    [sections addObject:mainSection];
    
    for (NSString* propertyName in model.properties)
    {
        if ([[model valueForKey:propertyName] isKindOfClass:[NSArray class]])
        {
            ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
            section.title = [self cleanCodeIdentifierString:propertyName];
            
            NSMutableArray* sectionItems = [NSMutableArray array];
            
            for (id item in [model valueForKey:propertyName])
            {
                ALPHAScreenItem* screenItem = [[ALPHAScreenItem alloc] init];
                screenItem.model = item;
                
                screenItem.title = [self cleanCodeIdentifierString:NSStringFromClass([item class])];
                screenItem.detail = [item description];
                
                [sectionItems addObject:screenItem];
            }
            
            section.items = sectionItems.copy;
            
            [sections addObject:section];
        }
        else
        {
            ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
            item.model = [model valueForKey:propertyName];
            item.title = [propertyName description];
            item.detail = [[model valueForKey:propertyName] description];
            
            [items addObject:item];
        }
    }
    
    mainSection.items = items.copy;
    
    screenModel.sections = sections.copy;
    
    return screenModel;
}

#pragma mark - Private methods

- (NSString *)cleanCodeIdentifierString:(NSString *)string
{
    return [self titleCaseForCamelCaseString:[self removeNamespacePrefixFromString:string]];
}

- (NSString *)removeNamespacePrefixFromString:(NSString *)string
{
    NSInteger location = 0;
    
    for (NSInteger i = 0; i < string.length; i++)
    {
        NSString *chr = [string substringWithRange:NSMakeRange(i, 1)];
        
        if ([chr rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)
        {
            location = i - 1;
            break;
        }
    }
    
    if (location < 0)
    {
        location = 0;
    }
    
    return [string substringFromIndex:location];

}

- (NSString *)titleCaseForCamelCaseString:(NSString *)camelCaseString
{
    NSMutableString *titleCase = [NSMutableString string];
    
    for (NSInteger i = 0; i < camelCaseString.length; i++)
    {
        NSString *chr = [camelCaseString substringWithRange:NSMakeRange(i, 1)];
        
        if ([chr rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)
        {
            [titleCase appendString:@" "];
        }
        
        [titleCase appendString:chr];
    }
    
    return titleCase;
}


@end
