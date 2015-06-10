//
//  ALPHAScreenManager.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"
#import "ALPHASerializerManager.h"
#import "ALPHAScreenManager.h"
#import "ALPHAConverterManager.h"
#import "ALPHALocalSource.h"

#import "ALPHANavigationController.h"

@interface ALPHAScreenManager () <ALPHAViewControllerDelegate>

@property (nonatomic, weak) UINavigationController* navigationController;

@end

@implementation ALPHAScreenManager

#pragma mark - Getters and Setters

- (ALPHATheme *)theme
{
    if (!_theme)
    {
        _theme = self.manager.theme;
    }
    
    return _theme;
}

- (ALPHAManager *)manager
{
    if (!_manager)
    {
        _manager = [ALPHAManager sharedManager];
    }
    
    return _manager;
}

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

+ (instancetype)defaultManager
{
    static id sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

#pragma mark - Public methods

- (void)pushObject:(id)object
{
    [self renderer:nil pushObject:object request:nil];
}

- (void)pushViewController:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(setDelegate:)])
    {
        [(id)viewController setDelegate:self];
    }
    
    if (!self.navigationController)
    {
        ALPHANavigationController *navigationController = [[ALPHANavigationController alloc] initWithRootViewController:viewController];
        
        [self.manager displayViewController:navigationController animated:YES completion:nil];
        
        self.navigationController = navigationController;
    }
    else
    {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/*!
 *  This is entry point for renderer when item is selected by either tapping or any other action
 *
 *  @param renderer renderer that currently displays the item
 *  @param item     displayed item
 */
- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer didSelectItem:(id)item
{
    //
    // When renderer selects item, first we check if it is an executable action and perform it. Menu actions
    // are ignored, because they
    //
    
    if (![item isKindOfClass:[ALPHAScreenActionItem class]] &&[item isKindOfClass:[ALPHAActionItem class]])
    {
        [renderer.source performAction:(ALPHAActionItem *)item completion:^(ALPHAModel *model, NSError *error)
        {
            if (!error)
            {
                [renderer refresh];
            }
        }];
    }
    else
    {
        //
        // Other items are usually a connection to another screen
        //
        
        [self renderer:renderer pushObject:item request:nil];
    }
}

#pragma mark - Private methods

/*!
 *  Pushes object by creating a new view controller,
 *
 *  @param object to push
 */
- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer pushObject:(id)object request:(ALPHARequest *)request
{
    //
    // Return here, we do not want to do anything further.
    //
    
    if ([object isKindOfClass:[ALPHAScreenItem class]] && [object object])
    {
        [self renderer:renderer pushObject:[(ALPHAScreenItem *)object object] request:nil];
        
        return;
    }

    Class class = [self.converter renderClassForObject:object];
    
    id<ALPHADataSource> source = renderer.source;
    
    if (!source)
    {
        source = [ALPHALocalSource new];
    }
    
    //
    // If we received no render class, likely we are unable to display a screen, because we have
    // a screen request.
    //
    
    if (!class)
    {
        if ([object isKindOfClass:[ALPHARequest class]])
        {
            request = object;
        }
        else if ([object isKindOfClass:[ALPHAScreenActionItem class]])
        {
            request = [(ALPHAScreenActionItem *)object request];
        }
        
        if (request)
        {
            [source dataForRequest:request completion:^(id newObject, NSError *error)
            {
                if (newObject)
                {
                    [self renderer:renderer pushObject:newObject request:request];
                }
            }];
            
            return;
        }
    }
    
    id controller = [[class alloc] init];
    
    if ([controller respondsToSelector:@selector(setRequest:)] && request)
    {
        [controller setRequest:request];
    }
    
    if ([controller respondsToSelector:@selector(setObject:)] && ![object isKindOfClass:[ALPHARequest class]])
    {
        [controller setObject:object];
    }
    
    //
    // Forward data source
    //
    if ([controller respondsToSelector:@selector(setSource:)])
    {
        [controller setSource:source];
    }
    
    if (controller)
    {
        [self pushViewController:controller];
    }
}

/*
- (void)openFileController:(NSString *)fullPath
{
    UIDocumentInteractionController *controller = [UIDocumentInteractionController new];
    controller.URL = [[NSURL alloc] initFileURLWithPath:fullPath];
    
    [controller presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
    self.documentController = controller;
}*/

#pragma mark - ALPHAViewControllerDelegate

- (void)viewControllerDidFinish:(UIViewController *)viewController
{
    /*if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
     {
     [self.delegate viewControllerDidFinish:self];
     }*/
    
    //
    // A child view controller has finished, remove it.
    //
    
    [self.manager removeViewControllerAnimated:YES completion:nil];
}


@end
