//
//  ALPHALocalSource.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHALocalSource.h"
#import "ALPHALocalFileSource.h"
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
        self.sources = [self loadSources];
    }
    
    return self;
}

- (NSArray *)loadSources
{
    NSArray* plugins = [ALPHAManager sharedManager].plugins;
    
    NSMutableArray *sources = [NSMutableArray array];
    
    for (ALPHAPlugin *plugin in plugins)
    {
        for (id<ALPHADataSource> source in plugin.sources)
        {
            [sources addObject:source];
        }
    }
    
    //
    // Insert file source
    //
    [sources addObject:[ALPHALocalFileSource new]];
    
    return [sources copy];
}

#pragma mark - ALPHADataSource

- (BOOL)hasDataForRequest:(ALPHARequest *)request
{
    return ([self sourceForRequest:request] != nil);
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceCompletion)completion
{
    id<ALPHADataSource> source = [self sourceForRequest:request];
    
    [source dataForRequest:request completion:^(ALPHAModel *model, NSError *error)
    {
        if (completion)
        {
            completion(model, error);
        }
    }];
}

- (BOOL)canPerformAction:(id<ALPHAIdentifiableItem>)action
{
    return ([self sourceForAction:action] != nil);
}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceCompletion)completion
{
    id<ALPHADataSource> source = [self sourceForAction:action];
    
    [source performAction:action completion:^(ALPHAModel *model, NSError *error)
    {
        if (completion)
        {
            completion(model, error);
        }
    }];
}

- (id<ALPHADataSource>)sourceForRequest:(ALPHARequest *)request
{
    id foundSource = nil;
    
    for (id<ALPHADataSource> source in self.sources)
    {
        if ([source hasDataForRequest:request])
        {
            foundSource = source;
            
            break;
        }
    }
    
    if ([foundSource respondsToSelector:@selector(isEnabled)])
    {
        foundSource = [foundSource isEnabled] ? foundSource : nil;
    }
    
    return foundSource;
}

- (id<ALPHADataSource>)sourceForAction:(id<ALPHAIdentifiableItem>)action
{
    id foundSource = nil;
    
    for (id<ALPHADataSource> source in self.sources)
    {
        if ([source respondsToSelector:@selector(canPerformAction:)] && [source canPerformAction:action] && [source respondsToSelector:@selector(performAction:completion:)])
        {
            foundSource = source;
            
            break;
        }
    }
    
    if ([foundSource respondsToSelector:@selector(isEnabled)])
    {
        foundSource = [foundSource isEnabled] ? foundSource : nil;
    }
    
    return foundSource;
}

@end
