//
//  ALPHAEventConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEventModel.h"
#import "ALPHATableScreenModel.h"

#import "ALPHAEventConverter.h"

@implementation ALPHAEventConverter

- (BOOL)canConvertObject:(ALPHAModel *)model
{
    return [model isKindOfClass:[ALPHAEventModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHAEventModel *)model
{
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:model.request.identifier];
    screenModel.title = @"Events";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHAApplicationEvent* event in model.events)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.object = [ALPHARequest requestForObject:event];
        
        item.title = event.name;
        item.detail = event.sender;
        item.style = UITableViewCellStyleSubtitle;
        
        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}


@end
