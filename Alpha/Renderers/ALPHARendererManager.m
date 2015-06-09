//
//  ALPHARendererManager.m
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"
#import "ALPHASerializerManager.h"
#import "ALPHARendererManager.h"
#import "ALPHAConverterManager.h"

@implementation ALPHARendererManager

#pragma mark - Getters and Setters

- (id<ALPHASerializer>)serializer
{
    if (!_serializer)
    {
        _serializer = [ALPHASerializerManager sharedManager];
    }
    
    return _serializer;
}

- (id<ALPHADataConverterSource>)converter
{
    if (!_converter)
    {
        _converter = [ALPHAConverterManager sharedManager];
    }
    
    return _converter;
}

+ (instancetype)sharedManager
{
    static id sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

#pragma mark - Public methods

- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer didSelectItem:(ALPHAScreenItem *)item
{
    if ([item isKindOfClass:[ALPHAActionItem class]] && ![item isKindOfClass:[ALPHAMenuActionItem class]])
    {
        [renderer.source performAction:(ALPHAActionItem *)item completion:^(ALPHAModel *model, NSError *error)
        {
            if (!error)
            {
                [renderer refresh];
            }
        }];
    }
    else if ([[item file] isKindOfClass:[NSURL class]] && [item fileClass])
    {
        ALPHARequest *fileRequest = [ALPHARequest requestForFile:[item file].absoluteString];
        
        [renderer.source dataForRequest:fileRequest completion:^(NSData *data, NSError *error)
        {
            id object = [[ALPHASerializerManager sharedManager].serializer deserializeObject:data toClass:[item fileClass]];
             
            [self renderer:renderer pushObject:object];
        }];
    }
    else
    {
        //
        // For data models that send data directly, we will display object view controller explorer
        //
        
        [self renderer:renderer pushObject:item];
    }
}

#pragma mark - Private methods

/*!
 *  Pushes object by creating a new view controller,
 *
 *  @param object to push
 */
- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer pushObject:(id)object
{
    id controller = nil;
    
    //
    // This is the model we are displaying, we will not display screen items as models
    //
    id modelObject = nil;
    
    if ([object isKindOfClass:[ALPHAMenuActionItem class]])
    {
        ALPHAMenuActionItem* menuItem = (ALPHAMenuActionItem *)object;
        
        controller = menuItem.viewControllerInstance;
    }
    
    if ([object isKindOfClass:[ALPHAScreenItem class]])
    {
        modelObject = [object object];
    }
    else
    {
        modelObject = object;
    }
    
    //
    // Handle custom objects
    //
    
    if (modelObject && !controller)
    {
        Class class = [[ALPHAConverterManager sharedManager] renderClassForObject:modelObject];
        
        if (class)
        {
            controller = [[class alloc] init];
            
            if ([controller respondsToSelector:@selector(setRequest:)] && [modelObject isKindOfClass:[ALPHARequest class]])
            {
                [controller setRequest:modelObject];
            }
            else if ([controller respondsToSelector:@selector(setObject:)])
            {
                [controller setObject:modelObject];
            }
        }
    }
    
    if ([controller respondsToSelector:@selector(setSource:)])
    {
        // Send data source
        [controller setSource:renderer.source];
    }
    
    if (controller)
    {
        [renderer.navigationController pushViewController:controller animated:YES];
    }
}

@end
