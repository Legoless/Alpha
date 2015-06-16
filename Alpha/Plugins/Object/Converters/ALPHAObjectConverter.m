//
//  ALPHAObjectConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <objc/runtime.h>

#import "ALPHAInstanceSource.h"

#import "ALPHAIvarRendererViewController.h"
#import "ALPHAMethodRendererViewController.h"
#import "ALPHAPropertyRendererViewController.h"

#import "NSString+ALPHAAdditional.h"

#import "FLEXRuntimeUtility.h"

#import "ALPHAObjectProperty.h"
#import "ALPHAObjectIvar.h"
#import "ALPHAObjectMethod.h"

#import "ALPHAObjectModel.h"

#import "ALPHATableScreenModel.h"

#import "ALPHAObjectConverter.h"

@implementation ALPHAObjectConverter

- (BOOL)canConvertObject:(id)object
{
    return [object isKindOfClass:[ALPHAObjectModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHAObjectModel *)object
{
    //
    // This is an exception that we send an empty identifier. We will not reload the object.
    //
    //
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithRequest:object.request];
    //model.title = [NSString stringWithFormat:@"Live Objects (%lu)", (unsigned long)totalCount];
    model.title = object.objectClass;
    
    model.searchBarPlaceholder = @"Filter";
    model.scopes = @[ @"No Inheritance", @"Include Inheritance" ];
    
    NSMutableArray* sections = [NSMutableArray array];
    
    //
    // Add sections
    //
    
    if (object.objectDescription)
    {
        [sections addObject:[self sectionForDescriptionWithModel:object]];
    }
    
    ALPHAScreenSection *section = [self sectionForObjectTypeWithModel:object];
    
    if (section)
    {
        [sections addObject:section];
    }
    
    [sections addObject:[self sectionForPropertyName:@"properties" inModel:object]];
    [sections addObject:[self sectionForPropertyName:@"ivars" inModel:object]];
    [sections addObject:[self sectionForPropertyName:@"methods" inModel:object]];
    [sections addObject:[self sectionForPropertyName:@"classMethods" inModel:object]];
    [sections addObject:[self sectionForPropertyName:@"superclasses" inModel:object]];
    
    if (!object.request.parameters[ALPHASearchTextParameterKey])
    {
        [sections addObject:[self sectionForObjectGraphWithObject:object]];
    }
    
    model.sections = sections.copy;
    
    model.expiration = 60.0;
    
    return model;
}

#pragma mark - Private methods

- (ALPHAScreenSection *)sectionForPropertyName:(NSString *)property inModel:(ALPHAObjectModel *)model
{
    ALPHAScreenSection *section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray* array = [model valueForKey:property];
    
    section.headerText = [[property alpha_titleCaseForCamelCase] stringByAppendingFormat:@" (%ld)", (long)array.count];
    
    for (id object in array)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.style = UITableViewCellStyleSubtitle;
        
        if ([object isKindOfClass:[ALPHAObjectProperty class]])
        {
            item.title = [object description];
            item.detail = [FLEXRuntimeUtility descriptionForIvarOrPropertyValue:[(ALPHAObjectProperty *)object value]];

        }
        else if ([object isKindOfClass:[ALPHAObjectIvar class]])
        {
            item.title = [object prettyDescription];
            item.detail = [FLEXRuntimeUtility descriptionForIvarOrPropertyValue:[(ALPHAObjectIvar *)object value]];
        }
        else if ([object isKindOfClass:[ALPHAObjectMethod class]])
        {
            item.title = [object prettyDescription];
        }
        else
        {
            item.title = [object description];
        }
        
        item.object = object;
        
        [items addObject:item];
    }
    
    section.items = items.copy;
    
    return section;
}

- (ALPHAScreenSection *)sectionForDescriptionWithModel:(ALPHAObjectModel *)model
{
    ALPHAScreenSection *section = [[ALPHAScreenSection alloc] init];
    section.headerText = @"Description";
    
    ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
    item.title = model.objectDescription;
    
    section.items = @[ item ];
    
    return section;

}

- (ALPHAScreenSection *)sectionForObjectTypeWithModel:(ALPHAObjectModel *)model
{
    //
    // If we have object content, build section from it.
    //
    
    NSMutableArray *items = [NSMutableArray array];
    
    Class class = NSClassFromString(model.objectMainSuperclass);
    
    ALPHAScreenSection *section = [[ALPHAScreenSection alloc] init];
    
    section.headerText = [self headerStringForClass:class];
    
    if (model.objectContent)
    {
        for (ALPHAObjectElement *item in model.objectContent.items)
        {
            ALPHAScreenItem *screenItem = [[ALPHAScreenItem alloc] init];
            
            screenItem.title = item.name;
            screenItem.detail = item.objectClass;
            
            screenItem.object = [ALPHARequest requestForObjectPointer:item.objectPointer className:item.objectClass];
        }
        
        section.items = items.copy;
        
        return section;
    }
    
    //
    // This represents specific object types and can add a special section, such as Array, Set, View,
    // Layer, etc. Equals to custom section on FLEXObjectExplorerViewController
    //
    
    //
    // Currently handled specific Foundation objects to add shortcuts that FLEX had.
    // - UIViewController
    // - UIView
    // - CALayer
    // - Class
    //
    
    NSArray *shortcuts = [self shortcutsForClass:class];
    
    if (shortcuts)
    {
        [items addObjectsFromArray:shortcuts];
    }
    
    //
    // Return section if we have a title
    //
    
    if (section.headerText)
    {
        section.items = items.copy;
        
        return section;
    }
    
    return nil;
}

- (NSString *)headerStringForClass:(Class)class
{
    if (class == [NSObject class])
    {
        return nil;
    }
    
    if (class == [NSArray class] || class == [NSMutableArray class])
    {
        return @"Array Indices";
    }
    
    if (class == [NSDictionary class] || class == [NSMutableDictionary class])
    {
        return @"Dictionary Objects";
    }
    
    if (class == [NSUserDefaults class])
    {
        return @"Defaults";
    }
    
    // Class instances, UIViewController, UIView, CALayer have shortcuts
    return @"Shortcuts";
}

- (NSArray *)shortcutsForClass:(Class)class
{
    if (class == [NSObject class])
    {
        return nil;
    }
    
    NSMutableArray *items = [NSMutableArray array];
    
    ALPHAScreenItem *item = nil;
    
    if (class == [UIViewController class])
    {
        item = [[ALPHAScreenItem alloc] init];
        item.title = @"Push View Controller";
        
        [items addObject:item];
        
        item = [[ALPHAScreenItem alloc] init];
        item.title = @"@property UIView *view";
        
        [items addObject:item];
    }
    else if (class == [UIView class])
    {
        item = [[ALPHAScreenItem alloc] init];
        item.title = @"View Controller";
        
        [items addObject:item];
        
        item = [[ALPHAScreenItem alloc] init];
        item.title = @"Preview Image";
        
        [items addObject:item];
    }
    else if (class == [CALayer class])
    {
        item = [[ALPHAScreenItem alloc] init];
        item.title = @"Preview Image";
        
        [items addObject:item];
    }
    else
    {
        item = [[ALPHAScreenItem alloc] init];
        item.title = @"Live Instances";
        item.object = [ALPHARequest requestWithIdentifier:ALPHAInstanceDataIdentifier parameters:@{ ALPHAInstanceDataClassNameIdentifier : NSStringFromClass(class) }];
        
        [items addObject:item];
    }

    return items.copy;
}

- (ALPHAScreenSection *)sectionForObjectGraphWithObject:(ALPHAObjectModel *)object
{
    ALPHAScreenSection *section = [[ALPHAScreenSection alloc] init];
    section.headerText = @"Object Graph";
    
    ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
    item.title = @"Other objects with ivars referencing this object";
    item.object = [ALPHARequest requestWithIdentifier:ALPHAInstanceDataIdentifier parameters:@{ ALPHAInstanceDataClassNameIdentifier : object.objectClass, ALPHAInstanceDataReferenceObjectIdentifier : object.objectPointer }];
    
    section.items = @[ item ];
    
    return section;
}

#pragma mark - Render class

- (Class)renderClassForObject:(id)object
{
    if ([object isKindOfClass:[ALPHAObjectMethod class]])
    {
        return [ALPHAMethodRendererViewController class];
    }
    else if ([object isKindOfClass:[ALPHAObjectProperty class]])
    {
        return [ALPHAPropertyRendererViewController class];
    }
    else if ([object isKindOfClass:[ALPHAObjectIvar class]])
    {
        return [ALPHAIvarRendererViewController class];
    }
    
    return nil;
}

@end
