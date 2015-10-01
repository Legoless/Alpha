//
//  ALPHABaseDataSource.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import ObjectiveC.runtime;

#import "ALPHABaseDataSource.h"
#import "ALPHAActions.h"

@interface ALPHABaseDataSource ()

@property (nonatomic, strong) NSMutableOrderedSet *identifiers;

@property (nonatomic, strong) NSMutableOrderedSet *actions;

@end

@implementation ALPHABaseDataSource

#pragma mark - Getters and Setters

- (NSMutableOrderedSet *)actions
{
    if (!_actions)
    {
        _actions = [NSMutableOrderedSet orderedSet];
    }
    
    return _actions;
}

- (NSMutableOrderedSet *)identifiers
{
    if (!_identifiers)
    {
        _identifiers = [NSMutableOrderedSet orderedSet];
    }
    
    return _identifiers;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.enabled = YES;
    }
    
    return self;
}

#pragma mark - Subclass convenience

- (void)addDataIdentifier:(NSString *)identifier
{
    [self.identifiers addObject:identifier];
}

- (void)addActionIdentifier:(NSString *)identifier
{
    [self.actions addObject:identifier];
}

#pragma mark - ALPHADataSource

- (void)hasDataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestVerification)completion
{
    if (!completion)
    {
        return;
    }
    
    BOOL result = self.isEnabled && [self.identifiers containsObject:request.identifier];
    
    completion (result);
}

- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceRequestCompletion)completion
{
    ALPHAModel *model = [self modelForRequest:request];
    
    if (completion)
    {
        completion (model, nil);
    }
}

- (void)canPerformAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestVerification)completion
{
    if (!completion)
    {
        return;
    }
    
    BOOL result = self.isEnabled && [self.actions containsObject:action.request.identifier];
    
    completion (result);
}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestCompletion)completion
{
    //
    // Default heuristics for executing actions
    //
    
    id object = nil;
    
    NSError* error = nil;
    
    if ([action isKindOfClass:[ALPHABlockActionItem class]])
    {
        ALPHABlockActionItem* blockAction = (ALPHABlockActionItem *)action;
        
        if (blockAction.actionBlock)
        {
            object = blockAction.actionBlock(self);
        }
    }
    else if ([action isKindOfClass:[ALPHASelectorActionItem class]])
    {
        ALPHASelectorActionItem* selectorAction = (ALPHASelectorActionItem *)action;
        
        SEL selector = NSSelectorFromString(selectorAction.selector);
        
        if (selectorAction.selector && [self respondsToSelector:selector])
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            NSMethodSignature* methodSig = [self methodSignatureForSelector:selector];
            
            const char* retType = [methodSig methodReturnType];
            
            if (strcmp(retType, @encode(id)) == 0)
            {
                object = [self performSelector:selector withObject:selectorAction.object];
            }
            else if (strcmp(retType, @encode(void)) == 0)
            {
                [self performSelector:selector withObject:selectorAction.object];
            }
            
            #pragma clang diagnostic pop
        }
    }
    else
    {
        error = [NSError errorWithDomain:@"com.unifiedsense.alpha.action.notimplemented" code:1 userInfo:@{ @"action" : action }];
    }
    
    if (completion)
    {
        completion (object, error);
    }
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    return nil;
}

@end
