//
//  ALPHAObjectConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

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
        [sections addObject:[self sectionForObjectGraph]];
    }
    
    model.sections = sections.copy;
    
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
            item.title = [FLEXRuntimeUtility appendName:[object propertyName] toType:[object propertyType]];
            item.detail = [object propertyValue];
        }
        else if ([object isKindOfClass:[ALPHAObjectIvar class]])
        {
            item.title = [FLEXRuntimeUtility appendName:[object ivarName] toType:[object ivarType]];
            item.detail = [object ivarValue];
        }
        else if ([object isKindOfClass:[ALPHAObjectMethod class]])
        {
            item.title = [object prettyDescription];
        }
        else
        {
            item.title = [object description];
        }
        
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
    // TODO: This represents specific object types and can add a special section, such as Array, Set, View,
    // Layer, etc.
    //
    return nil;
}

- (ALPHAScreenSection *)sectionForObjectGraph
{
    ALPHAScreenSection *section = [[ALPHAScreenSection alloc] init];
    section.headerText = @"Object Graph";
    
    ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
    item.title = @"Other objects with ivars referencing this object";
    
    section.items = @[ item ];
    
    return section;
}

@end
