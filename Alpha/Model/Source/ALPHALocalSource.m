//
//  ALPHALocalSource.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHALocalSource.h"
#import "ALPHAManager.h"
#import "ALPHAModel.H"

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

#pragma mark - Refresh

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
                [collector collectDataForIdentifier:identifier completion:^(ALPHAModel *model, NSError *error) {
                    
                    if (model)
                    {
                        data[identifier] = model;
                    }
                    else if (error)
                    {
                        data[identifier] = error;
                    }
                    else
                    {
                        [data removeObjectForKey:identifier];
                    }
                    
                    [self finishWithData:data completion:completion];
                }];
            }
        }
    }
}

- (void)fileWithURL:(NSURL *)url completion:(ALPHADataSourceCompletion)completion
{
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
    
    if (completion)
    {
        completion(data, error);
    }
}

#pragma mark - Actions

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceCompletion)completion
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    //
    // First find collectors
    //
    
    for (ALPHADataCollector *collector in self.collectors)
    {
        if ([collector canPerformAction:action])
        {
            data[action.identifier] = [NSNull null];
        }
    }
    
    for (ALPHADataCollector *collector in self.collectors)
    {
        if ([collector canPerformAction:action])
        {
            [collector performAction:action completion:^(ALPHAModel *model, NSError *error)
            {
                if (model)
                {
                    data[action.identifier] = model;
                }
                else if (error)
                {
                    data[action.identifier] = error;
                }
                else
                {
                    [data removeObjectForKey:action.identifier];
                }
                
                [self finishWithData:data completion:completion];
            }];
        }
    }
}

- (void)completeData:(NSDictionary *)data completion:(ALPHADataSourceCompletion)completion
{
    if (!completion)
    {
        return;
    }
    
    //
    // Find error
    //
    
    NSError* error = nil;
    id value = nil;
    
    for (id key in data)
    {
        if ([data[key] isKindOfClass:[NSError class]] && !error)
        {
            error = data[key];
        }
        else if (!value)
        {
            value = data[key];
        }
        else
        {
            break;
        }
    }
    
    completion (value, error);
}

- (void)finishWithData:(NSDictionary *)data completion:(ALPHADataSourceCompletion)completion
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
    
    [self completeData:data completion:completion];
}

@end
