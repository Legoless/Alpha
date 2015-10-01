//
//  ALPHAPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAPlugin.h"

@interface ALPHAPlugin ()

@property (nonatomic, strong, readwrite) NSString* identifier;
@property (nonatomic, strong) NSMutableOrderedSet* baseActions;
@property (nonatomic, strong) NSMutableOrderedSet* baseSources;

@end

@implementation ALPHAPlugin

#pragma mark - Getters and Setters

- (NSString *)title
{
    NSString* classString = NSStringFromClass([self class]);
    
    classString = [classString stringByReplacingOccurrencesOfString:@"ALPHA" withString:@""];

    classString = [classString stringByReplacingOccurrencesOfString:@"Plugin" withString:@""];
    
    return classString;
}

- (NSMutableOrderedSet *)baseActions
{
    if (!_baseActions)
    {
        _baseActions = [NSMutableOrderedSet orderedSet];
    }
    
    return _baseActions;
}

- (NSMutableOrderedSet *)baseSources
{
    if (!_baseSources)
    {
        _baseSources = [NSMutableOrderedSet orderedSet];
    }
    
    return _baseSources;
}

- (NSArray *)actions
{
    return [self.baseActions array];
}

- (NSArray *)sources
{
    return [self.baseSources array];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    //
    // If plugin is disabled, all collectors will be disabled too
    //
    
    for (id<ALPHADataSource> source in self.sources)
    {
        if ([source respondsToSelector:@selector(setEnabled:)])
        {
            source.enabled = enabled;
        }
    }
}

#pragma mark - Initialization

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Identifier missing." reason:@"Plugin requires identifier to be defined." userInfo:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    
    if (self)
    {
        self.enabled = YES;
        self.identifier = identifier;
    }
    
    return self;
}

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return NO;
}

- (void)registerAction:(ALPHAActionItem *)action
{
    for (ALPHAActionItem* actionItem in self.baseActions)
    {
        if ([actionItem.request.identifier isEqualToString:action.request.identifier])
        {
            @throw [NSException exceptionWithName:@"Action equal identifiers" reason:@"Actions must have unique identifiers" userInfo:@{ @"action" : action }];
        }
    }
    
    [self.baseActions addObject:action];
}

- (void)registerSource:(id<ALPHADataSource>)source
{
    [self.baseSources addObject:source];
}

@end
