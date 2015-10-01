//
//  ALPHAViewHierarchySource.m
//  Alpha
//
//  Created by Dal Rupnik on 15/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAViewHierarchyModel.h"
#import "ALPHAViewHierarchySource.h"

#import "ALPHAManager.h"

NSString *const ALPHAViewDataIdentifier         = @"com.unifiedsense.alpha.data.view";
NSString *const ALPHAViewDataPointerIdentifier  = @"com.unifiedsense.alpha.data.view.specific";

@implementation ALPHAViewHierarchySource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAViewDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    ALPHAViewHierarchyModel *model = [[ALPHAViewHierarchyModel alloc] initWithRequest:request];
    
    NSArray *allViews = [self allViewsInHierarchy];
    
    NSMutableArray *serializableViews = [NSMutableArray array];
    
    for (UIView *view in allViews)
    {
        [serializableViews addObject:[[ALPHASerializableView alloc] initWithView:view]];
    }
    
    NSArray *serializedViews = serializableViews.copy;
    
    if ([request.parameters[ALPHASearchTextParameterKey] length])
    {
        serializedViews = [serializedViews filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(ALPHASerializableView *candidateView, NSDictionary *bindings)
        {
            NSString *title = candidateView.viewDescription;
            return [title rangeOfString:request.parameters[ALPHASearchTextParameterKey] options:NSCaseInsensitiveSearch].location != NSNotFound;
        }]];
    }
    
    model.views = (NSArray<ALPHASerializableView> *)serializedViews;
    
    return model;
}

- (NSArray *)allViewsInHierarchy
{
    NSMutableArray *allViews = [NSMutableArray array];
    NSArray *windows = [[ALPHAManager defaultManager] allWindows];
    
    for (UIWindow *window in windows)
    {
        //
        // Ignore Alpha window
        //
        if (window != [ALPHAManager defaultManager].alphaWindow)
        {
            [allViews addObject:window];
            [allViews addObjectsFromArray:[self allRecursiveSubviewsInView:window]];
        }
    }
    
    return allViews;
}

- (NSArray *)allRecursiveSubviewsInView:(UIView *)view
{
    NSMutableArray *subviews = [NSMutableArray array];
    
    for (UIView *subview in view.subviews)
    {
        [subviews addObject:subview];
        [subviews addObjectsFromArray:[self allRecursiveSubviewsInView:subview]];
    }
    
    return subviews;
}

@end
