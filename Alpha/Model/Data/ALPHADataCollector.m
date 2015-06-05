//
//  ALPHADataCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHADataCollector.h"
#import "ALPHAActions.h"

@interface ALPHADataCollector ()

@property (nonatomic, strong) NSMutableOrderedSet *identifiers;

@property (nonatomic, strong) NSMutableOrderedSet *actions;
@end

@implementation ALPHADataCollector

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

- (void)addDataIdentifier:(NSString *)identifier
{
    [self.identifiers addObject:identifier];
}

- (void)addActionIdentifier:(NSString *)identifier
{
    [self.actions addObject:identifier];
}

- (BOOL)canPerformActionForIdentifier:(NSString *)identifier
{
    return [self.actions containsObject:identifier];
}

- (BOOL)canPerformAction:(ALPHAActionItem *)action
{
    return [self canPerformActionForIdentifier:action.identifier];
}

- (BOOL)hasDataForIdentifier:(NSString *)identifier
{
    return [self.identifiers containsObject:identifier];
}

- (void)collectDataForIdentifier:(NSString *)identifier completion:(void (^)(ALPHAModel *, NSError *))completion
{
    if (completion)
    {
        completion([self model], nil);
    }
}

- (void)performAction:(ALPHAActionItem *)action completion:(ALPHADataSourceCompletion)completion
{
    //
    // Default heuristics for executing actions
    //
    
    if ([action isKindOfClass:[ALPHABlockActionItem class]])
    {
        ALPHABlockActionItem* blockAction = (ALPHABlockActionItem *)action;
        
        if (blockAction.actionBlock)
        {
            blockAction.actionBlock(self);
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
            
            [self performSelector:selector withObject:selectorAction.model];
            
            #pragma clang diagnostic pop
        }
    }
}

- (void)performActionWithIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion
{
    
}

- (ALPHAModel *)model
{
    return nil;
}

@end
