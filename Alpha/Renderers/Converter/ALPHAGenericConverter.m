//
//  ALPHAGenericConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "NSString+Identifier.h"
#import "NSObject+Property.h"

#import "ALPHAScreenActionItem.h"

#import "ALPHAGenericConverter.h"
#import "ALPHAGenericModel.h"
#import "ALPHATableScreenModel.h"
#import "ALPHATableRendererViewController.h"
#import "ALPHAImageRendererViewController.h"
#import "ALPHAWebRendererViewController.h"

@implementation ALPHAGenericConverter

#pragma mark - ALPHADataConverterSource

- (BOOL)canConvertObject:(id)object
{
    return [object isKindOfClass:[ALPHAModel class]];
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

    //
    // Attempt to convert to screen model using class info
    //
    
    return [self convertCustomObject:object];
}

- (Class)renderClassForObject:(id)object
{
    //
    // If Alpha request is provided, we must first execute the request, because we do not know
    // which class can render it. Return nil here, so it can be properly handled.
    //
    
    if ([object isKindOfClass:[ALPHARequest class]])
    {
        return nil;
    }
    
    //
    // If we have a model, but no other converter has a render class, we return table data renderer.
    // Here, because we know how to convert both Generic and any model.
    //
    if ([object isKindOfClass:[ALPHAModel class]])
    {
        return [ALPHATableRendererViewController class];
    }
    
    //
    // If we have a screen action item, the action item probably has information about what class
    // should be rendered.
    //
    if ([object isKindOfClass:[ALPHAScreenActionItem class]])
    {
        ALPHAScreenActionItem *screenAction = (ALPHAScreenActionItem *)object;
        
        if (screenAction.viewControllerClass)
        {
            Class screenClass = NSClassFromString(screenAction.viewControllerClass);
            
            if (screenClass)
            {
                return screenClass;
            }
        }
        
        if (screenAction.request)
        {
            return [self renderClassForObject:screenAction.request];
        }
    }
    
    //
    // Map custom objects
    //
    
    NSDictionary *explorerSubclassesForObjectTypeStrings = @{
         NSStringFromClass([NSString class])         : [ALPHAWebRendererViewController class],
         NSStringFromClass([NSURL class])            : [ALPHAWebRendererViewController class],
         NSStringFromClass([UIImage class])          : [ALPHAImageRendererViewController class]
    };

    Class explorerClass = nil;
    
    BOOL objectIsClass = class_isMetaClass(object_getClass(object));
    
    if (objectIsClass)
    {
        explorerClass = [ALPHATableRendererViewController class];
    }
    else
    {
        explorerClass = [ALPHATableRendererViewController class];
        
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
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
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
    
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
    screenModel.title = [NSStringFromClass([model class]) alpha_cleanCodeIdentifier];
    
    ALPHAScreenSection* mainSection = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* sections = [NSMutableArray array];
    NSMutableArray* items = [NSMutableArray array];
    
    [sections addObject:mainSection];
    
    for (NSString* propertyName in model.alpha_properties)
    {
        if ([[model valueForKey:propertyName] isKindOfClass:[NSArray class]])
        {
            ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
            section.headerText = [propertyName alpha_cleanCodeIdentifier];
            
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
