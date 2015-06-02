//
//  ALPHAMenuDataCollector.m
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMenuDataCollector.h"
#import "ALPHAManager.h"
#import "ALPHAMenuActionItem.h"
#import "ALPHAGlobalActions.h"
#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"

NSString* const ALPHAMenuDataIdentifier = @"com.unifiedsense.alpha.data.menu";

@implementation ALPHAMenuDataCollector

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAMenuDataIdentifier];
    }
    
    return self;
}


- (ALPHAModel *)model
{
    NSArray* plugins = [ALPHAManager sharedManager].plugins;
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (ALPHAPlugin* plugin in plugins)
    {
        if (!plugin.isEnabled)
        {
            continue;
        }
        
        for (ALPHAActionItem* action in plugin.actions)
        {
            if ([action isKindOfClass:[ALPHAMenuActionItem class]] && action.isEnabled)
            {
                [items addObject:action];
            }
        }
    }
    
    NSSortDescriptor* prioritySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:YES];
    NSSortDescriptor* titleSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAMenuDataIdentifier];
    section.items = [items sortedArrayUsingDescriptors:@[ prioritySortDescriptor, titleSortDescriptor ]];;
    
    ALPHAScreenModel* dataModel = [[ALPHAScreenModel alloc] initWithIdentifier:ALPHAMenuDataIdentifier];
    dataModel.title = @"Alpha";
    dataModel.sections = @[ section ];
    
    //
    // Close action
    //
    
    ALPHAActionItem* closeAction = [[ALPHAActionItem alloc] initWithIdentifier:ALPHAActionCloseIdentifier];
    
    dataModel.rightAction = closeAction;
    
    return dataModel;
}

@end
