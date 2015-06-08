//
//  ALPHAGenericConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <objc/runtime.h>
#import <Haystack/Haystack.h>

#import "NSString+ALPHAAdditional.h"

#import "FLEXObjectExplorerViewController.h"
#import "FLEXArrayExplorerViewController.h"
#import "FLEXSetExplorerViewController.h"
#import "FLEXDictionaryExplorerViewController.h"
#import "FLEXDefaultsExplorerViewController.h"
#import "FLEXViewControllerExplorerViewController.h"
#import "FLEXViewExplorerViewController.h"
#import "FLEXImageExplorerViewController.h"
#import "FLEXImagePreviewViewController.h"
#import "FLEXClassExplorerViewController.h"

#import "ALPHAGenericConverter.h"
#import "ALPHAGenericModel.h"
#import "ALPHATableScreenModel.h"
#import "ALPHATableDataRendererViewController.h"

@implementation ALPHAGenericConverter

#pragma mark - ALPHADataConverterSource

- (BOOL)canConvertObject:(id)object
{
    return [object isKindOfClass:[ALPHAModel class]] || [object isKindOfClass:[UIImage class]];
}

- (ALPHAScreenModel *)screenModelForObject:(id)object
{
    //
    // Heuristics to use data property in generic model
    //
    
    if ([object isKindOfClass:[ALPHAGenericModel class]])
    {
        return [self convertGenericModel:(ALPHAGenericModel *)object];
    }
    else if ([object isKindOfClass:[ALPHAModel class]])
    {
        return [self convertCustomModel:object];
    }
    //
    // Attempt to convert to screen model using class info
    //
    
    return [self convertCustomObject:object];
}

- (Class)renderClassForObject:(id)object
{
    if ([object isKindOfClass:[ALPHAModel class]])
    {
        return [ALPHATableDataRendererViewController class];
    }
    //
    // Map custom objects
    //
    
    NSDictionary *explorerSubclassesForObjectTypeStrings = @{
         NSStringFromClass([NSArray class])          : [FLEXArrayExplorerViewController class],
         NSStringFromClass([NSSet class])            : [FLEXSetExplorerViewController class],
         NSStringFromClass([NSDictionary class])     : [FLEXDictionaryExplorerViewController class],
         NSStringFromClass([NSUserDefaults class])   : [FLEXDefaultsExplorerViewController class],
         NSStringFromClass([UIViewController class]) : [FLEXViewControllerExplorerViewController class],
         NSStringFromClass([UIView class])           : [FLEXViewExplorerViewController class],
         NSStringFromClass([UIImage class])          : [FLEXImageExplorerViewController class]
    };

    Class explorerClass = nil;
    
    BOOL objectIsClass = class_isMetaClass(object_getClass(object));
    if (objectIsClass)
    {
        explorerClass = [FLEXClassExplorerViewController class];
    }
    else
    {
        explorerClass = [FLEXObjectExplorerViewController class];
        
        for (NSString *objectTypeString in explorerSubclassesForObjectTypeStrings)
        {
            Class objectClass = NSClassFromString(objectTypeString);
            
            if ([object isKindOfClass:objectClass])
            {
                explorerClass = [explorerSubclassesForObjectTypeStrings objectForKey:objectTypeString];
                break;
            }
        }
    }
    
    return explorerClass;
}

#pragma mark - Generic model conversion

- (ALPHAScreenModel *)convertGenericModel:(ALPHAGenericModel *)model
{
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.identifier];
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
    
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.identifier];
    screenModel.title = [NSStringFromClass([model class]) alpha_cleanCodeIdentifier];
    
    ALPHAScreenSection* mainSection = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* sections = [NSMutableArray array];
    NSMutableArray* items = [NSMutableArray array];
    
    [sections addObject:mainSection];
    
    for (NSString* propertyName in model.properties)
    {
        if ([[model valueForKey:propertyName] isKindOfClass:[NSArray class]])
        {
            ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
            section.title = [propertyName alpha_cleanCodeIdentifier];
            
            NSMutableArray* sectionItems = [NSMutableArray array];
            
            for (id item in [model valueForKey:propertyName])
            {
                ALPHAScreenItem* screenItem = [[ALPHAScreenItem alloc] init];
                screenItem.object = item;
                
                screenItem.title = [NSStringFromClass([item class]) alpha_cleanCodeIdentifier];
                screenItem.detail = [item description];
                
                [sectionItems addObject:screenItem];
            }
            
            section.items = sectionItems.copy;
            
            [sections addObject:section];
        }
        else
        {
            ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
            item.object = [model valueForKey:propertyName];
            item.title = [propertyName description];
            item.detail = [[model valueForKey:propertyName] description];
            
            [items addObject:item];
        }
    }
    
    mainSection.items = items.copy;
    
    screenModel.sections = sections.copy;
    
    return screenModel;
}

#pragma mark - Custom objects

- (ALPHAScreenModel *)convertCustomObject:(id)object
{
    return [ALPHAScreenModel new];
}

@end
