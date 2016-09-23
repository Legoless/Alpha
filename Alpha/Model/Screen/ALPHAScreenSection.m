//
//  ALPHAScreenSection.m
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenSection.h"
#import "ALPHAScreenItem.h"
#import "ALPHASerialization.h"

@implementation ALPHAScreenSection

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (instancetype)screenSectionWithDictionary:(NSDictionary *)dictionary
{
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSNumber* style = nil;
    
    for (NSString* key in dictionary)
    {
        if ([key isEqualToString:@"items"])
        {
            NSMutableArray* items = [NSMutableArray array];
            
            for (id item in dictionary[key])
            {
                ALPHAScreenItem* displayItem = nil;
                
                if ([item isKindOfClass:[ALPHAScreenItem class]])
                {
                    displayItem = item;
                }
                else if ([item isKindOfClass:[NSDictionary class]])
                {
                    displayItem = [[ALPHAScreenItem alloc] init];
                
                    for (id keyItem in item)
                    {
                        if ([keyItem isKindOfClass:[NSString class]])
                        {
                            displayItem.titleText = keyItem;
                        }
                        else if ([keyItem isKindOfClass:[NSAttributedString class]])
                        {
                            displayItem.attributedTitleText = keyItem;
                        }
                        else
                        {
                            displayItem.title = keyItem;
                        }
                        
                        if ([item[keyItem] isKindOfClass:[NSString class]])
                        {
                            displayItem.detailText = [item[keyItem] description];
                        }
                        else if ([keyItem isKindOfClass:[NSAttributedString class]])
                        {
                            displayItem.attributedTitleText = item[keyItem];
                        }
                        else
                        {
                            displayItem.detail = item[keyItem];
                        }
                    }
                }
                else
                {
                    displayItem = [[ALPHAScreenItem alloc] init];
                    displayItem.titleText = NSStringFromClass([item class]);
                    displayItem.detailText = [item description];
                    displayItem.object = item;
                }
                
                if (displayItem)
                {
                    [items addObject:displayItem];
                }
            }
            
            section.items = items;
        }
        else if ([key isEqualToString:@"style"])
        {
            style = dictionary[key];
        }
        else
        {
            // Sets title and identifier
            [section setValue:dictionary[key] forKey:key];
        }
    }
    
    //
    // Handle styles
    //
    
    if (style)
    {
        UITableViewCellStyle cellStyle = (UITableViewCellStyle)style.integerValue;
        
        for (ALPHAScreenItem* item in section.items)
        {
            item.style = cellStyle;
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
        self.headerText = title;
    }
    
    return self;
}

@end
