//
//  ALPHAViewHierarchyConverter.m
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "UIColor+Utility.h"

#import "ALPHATableScreenModel.h"

#import "ALPHAViewHierarchyModel.h"

#import "ALPHAViewHierarchyConverter.h"
#import "ALPHAHeapUtility.h"

@implementation ALPHAViewHierarchyConverter

- (BOOL)canConvertObject:(id)object
{
    return [object isKindOfClass:[ALPHAViewHierarchyModel class]];
}

- (ALPHAScreenModel *)screenModelForObject:(ALPHAViewHierarchyModel *)object
{
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHASerializableView *view in object.views)
    {
        ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
        item.style = UITableViewCellStyleSubtitle;
        
        item.title = view.viewDescription;
        item.detail = [NSString stringWithFormat:@"Frame: %@", view.frame];
        
        item.cellClass = @"ALPHAHierarchyTableViewCell";
        
        id originalView = [ALPHAHeapUtility objectForPointerString:view.viewPointer className:nil];
        item.cellParameters = @{ @"viewDepth" : @(view.depth), @"viewColor" : [UIColor alpha_consistentRandomColorForObject:originalView] };
        
        item.transparent = view.hidden;
        
        item.object = [ALPHARequest requestForObject:view];
        
        [items addObject:item];
    }
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:object.request.identifier];
    section.items = items.copy;
    
    ALPHATableScreenModel *model = [[ALPHATableScreenModel alloc] initWithRequest:object.request];
    model.title = @"View Hierarchy";
    model.separatorStyle = UITableViewCellSeparatorStyleNone;
    model.rowHeight = 50.0;
    
    model.searchBarPlaceholder = @"Filter";
    //model.scopes = @[ @"Views at Tap", @"Full Hierarchy" ];
    
    model.sections = @[ section ];
    model.expiration = 60;

    return model;
}

@end
