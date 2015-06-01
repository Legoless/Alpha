//
//  FLEXDisplaySection.m
//  UICatalog
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSection.h"
#import "ALPHADataItem.h"

@implementation ALPHADataSection

+ (instancetype)dataSectionWithDictionary:(NSDictionary *)dictionary
{
    ALPHADataSection* section = [[ALPHADataSection alloc] init];
    
    for (NSString* key in dictionary)
    {
        if ([key isEqualToString:@"items"])
        {
            NSMutableArray* items = [NSMutableArray array];
            
            for (NSDictionary* item in dictionary[key])
            {
                ALPHADataItem* displayItem = [[ALPHADataItem alloc] init];
                
                for (NSString* keyItem in item)
                {
                    displayItem.title = keyItem;
                    displayItem.detail = [item[keyItem] description];
                }
                
                [items addObject:displayItem];
            }
            
            section.items = items;
        }
        else
        {
            // Sets title and identifier
            [section setValue:dictionary[key] forKey:key];
        }
    }
    
    return section;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return [self initWithIdentifier:identifier title:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title
{
    self = [super init];
    
    if (self)
    {
        self.identifier = identifier;
        self.title = title;
    }
    
    return self;
}

@end
