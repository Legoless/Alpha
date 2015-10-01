//
//  ALPHALocalSource.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHALocalSource.h"
#import "ALPHALocalFileSource.h"
#import "ALPHAModel.h"
#import "ALPHAPlugin.h"

@interface ALPHALocalSource ()

@end

@implementation ALPHALocalSource

- (void)loadSourcesFromPlugins:(NSArray *)plugins
{
    NSMutableArray *sources = [plugins valueForKeyPath:@"@unionOfArrays.sources"];
    //
    // Insert file source
    //
    [sources addObject:[ALPHALocalFileSource new]];
    
    self.sources = [sources copy];
}

#pragma mark - ALPHADataSource

- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{
    if (completion)
    {
        completion(([self sourceForRequest:request] != nil));
    }
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestCompletion)completion
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

- (void)canPerformAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestVerification)completion;
{
    if (completion)
    {
        completion(([self sourceForAction:action] != nil));
    }
}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestCompletion)completion
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
    __block id foundSource = nil;
    
    for (id<ALPHADataSource> source in self.sources)
    {
        [source hasDataForRequest:request completion:^(BOOL result)
        {
            if (result)
            {
                foundSource = source;
            }
        }];
    }
    
    if ([foundSource respondsToSelector:@selector(isEnabled)])
    {
        foundSource = [foundSource isEnabled] ? foundSource : nil;
    }
    
    return foundSource;
}

- (id<ALPHADataSource>)sourceForAction:(id<ALPHAIdentifiableItem>)action
{
    __block id foundSource = nil;
    
    for (id<ALPHADataSource> source in self.sources)
    {
        if ([source respondsToSelector:@selector(canPerformAction:completion:)] && [source respondsToSelector:@selector(performAction:completion:)])
        {
            [source canPerformAction:action completion:^(BOOL result)
            {
                if (result)
                {
                    foundSource = source;
                }
            }];
        }
    }
    
    if ([foundSource respondsToSelector:@selector(isEnabled)])
    {
        foundSource = [foundSource isEnabled] ? foundSource : nil;
    }
    
    return foundSource;
}

@end
