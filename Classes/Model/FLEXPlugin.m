//
//  FLEXPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXPlugin.h"

@interface FLEXPlugin ()

@property (nonatomic, strong, readwrite) NSString* identifier;
@property (nonatomic, strong) NSMutableArray* baseActions;

@end

@implementation FLEXPlugin

- (NSString *)title
{
    NSString* classString = NSStringFromClass([self class]);
    
    classString = [classString stringByReplacingOccurrencesOfString:@"FLEX" withString:@""];
    classString = [classString stringByReplacingOccurrencesOfString:@"Plugin" withString:@""];
    
    return classString;
}

- (NSMutableArray *)baseActions
{
    if (!_baseActions)
    {
        _baseActions = [NSMutableArray array];
    }
    
    return _baseActions;
}

- (NSArray *)actions
{
    return self.baseActions;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Identifier missing." reason:@"FLEX Plugin requires identifier to be defined." userInfo:nil];
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

- (void)registerAction:(FLEXActionItem *)action
{
    for (FLEXActionItem* actionItem in self.baseActions)
    {
        if ([actionItem.identifier isEqualToString:action.identifier])
        {
            @throw [NSException exceptionWithName:@"Action equal identifiers" reason:@"Actions must have unique identifiers" userInfo:@{ @"action" : action }];
        }
    }
    
    [self.baseActions addObject:action];
}

@end
