//
//  FLEXPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 19/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXPlugin.h"

@interface FLEXPlugin ()

@property (nonatomic, strong) NSMutableArray* baseActions;

@end

@implementation FLEXPlugin

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
    self = [super init];
    
    if (self)
    {
        self.enabled = YES;
    }
    
    return self;
}

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return NO;
}

- (void)registerAction:(FLEXActionItem *)action
{
    //
    // TODO: Add checks for identifier
    //
    [self.baseActions addObject:action];
}

@end
