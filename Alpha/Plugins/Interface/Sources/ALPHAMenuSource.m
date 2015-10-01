//
//  ALPHAMenuSource.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMenuSource.h"
#import "ALPHAManager.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHAGlobalActionIdentifiers.h"
#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"
#import "ALPHATableScreenModel.h"

NSString* const ALPHAMenuDataIdentifier = @"com.unifiedsense.alpha.data.menu";

@implementation ALPHAMenuSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAMenuDataIdentifier];
    }
    
    return self;
}


- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    NSArray* plugins = [ALPHAManager defaultManager].plugins;
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (ALPHAPlugin* plugin in plugins)
    {
        if (!plugin.isEnabled)
        {
            continue;
        }
        
        for (ALPHAActionItem* action in plugin.actions)
        {
            if ([action isKindOfClass:[ALPHAScreenActionItem class]] && action.isEnabled)
            {
                ALPHAScreenActionItem *menuAction = (ALPHAScreenActionItem *)action;
                
                if (menuAction.isMain)
                {
                    [items addObject:action];
                }
            }
        }
    }
    
    NSSortDescriptor* prioritySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:YES];
    NSSortDescriptor* titleSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAMenuDataIdentifier];
    section.items = [items sortedArrayUsingDescriptors:@[ prioritySortDescriptor, titleSortDescriptor ]];
    
    ALPHATableScreenModel* dataModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAMenuDataIdentifier];
    dataModel.title = @"Alpha";
    dataModel.sections = @[ section ];
    
    return dataModel;
}

@end
