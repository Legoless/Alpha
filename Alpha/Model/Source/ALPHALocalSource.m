//
//  ALPHALocalSource.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHALocalSource.h"
#import "ALPHAManager.h"

@interface ALPHALocalSource ()

@end

@implementation ALPHALocalSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.collectors = [self loadCollectors];
    }
    
    return self;
}

- (NSArray *)loadCollectors
{
    NSArray* plugins = [ALPHAManager sharedManager].plugins;
    
    NSMutableArray *collectors = [NSMutableArray array];
    
    for (ALPHAPlugin *plugin in plugins)
    {
        for (ALPHADataCollector *collector in plugin.collectors)
        {
            [collectors addObject:collector];
        }
    }
    
    return [collectors copy];
}

- (void)refreshWithIdentifiers:(NSArray *)identifiers completion:(ALPHADataSourceCompletion)completion
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    //
    // First find collectors
    //
    
    for (NSString *identifier in identifiers)
    {
        for (ALPHADataCollector *collector in self.collectors)
        {
            if ([collector hasDataForIdentifier:identifier])
            {
                data[identifier] = [NSNull null];
            }
        }
    }
    
    //
    // Then collect data from all collectors
    //
    
    for (NSString *identifier in identifiers)
    {
        for (ALPHADataCollector *collector in self.collectors)
        {
            if ([collector hasDataForIdentifier:identifier])
            {
                [collector collectDataForIdentifier:identifier completion:^(ALPHADataModel *model, NSError *error) {
                    
                    if (model)
                    {
                        data[identifier] = model;
                    }
                    else
                    {
                        data[identifier] = error;
                    }
                    
                    [self completeRefreshWithIdentifiers:identifiers data:data completion:completion];
                }];
            }
        }
    }
}

- (void)completeRefreshWithIdentifiers:(NSArray *)identifiers data:(NSDictionary *)data completion:(ALPHADataSourceCompletion)completion
{
    //
    // We have three states of the refresh
    //
    // - Data was not found for collectors
    // - Data is still loading for collectors
    // - Data has finished loading for all collectors
    //
    
    //
    // Check if any identifiers are still pending
    //
    
    BOOL pending = NO;
    
    for (id object in data)
    {
        if ([object isKindOfClass:[NSNull class]])
        {
            pending = YES;
            break;
        }
    }
    
    if (pending)
    {
        return;
    }
    
    //
    // Once completed return
    //
    
    if (completion)
    {
        completion(data.allValues.firstObject, nil);
    }
}

- (void)performActionsWithIdentifiers:(NSArray *)identifiers completion:(ALPHADataSourceCompletion)completion
{
    
}

@end
