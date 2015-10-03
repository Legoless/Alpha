//
//  ALPHAScreenManager.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"
#import "ALPHAScreenManager.h"
#import "ALPHALocalSource.h"
#import "ALPHAManager.h"

#import "ALPHANavigationController.h"

@interface ALPHAScreenManager () <ALPHAViewControllerDelegate>

@property (nonatomic, weak) UINavigationController* navigationController;

@end

@implementation ALPHAScreenManager

#pragma mark - Getters and Setters

- (ALPHATheme *)theme
{
    return self.manager.theme;
}

- (ALPHAManager *)manager
{
    if (!_manager)
    {
        _manager = [ALPHAManager defaultManager];
    }
    
    return _manager;
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
    [self renderer:nil pushObject:object request:nil source:nil];
}

- (void)pushViewController:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(setDelegate:)] && [viewController respondsToSelector:@selector(delegate)])
    {
        if (![(id)viewController delegate])
        {
            [(id)viewController setDelegate:self];
        }
    }
    
    if ([viewController respondsToSelector:@selector(setTheme:)])
    {
        [(id)viewController setTheme:self.theme];
    }
    
    if (viewController.navigationController && !self.navigationController)
    {
        self.navigationController = viewController.navigationController;
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
    
    if (![item isKindOfClass:[ALPHAScreenActionItem class]] && [item isKindOfClass:[ALPHAActionItem class]])
    {
        [renderer.source performAction:(ALPHAActionItem *)item completion:^(ALPHAModel *model, NSError *error)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                if (!error)
                {
                    [renderer refresh];
                }
            });
        }];
    }
    else
    {
        //
        // Other items are usually a connection to another screen
        //
        
        [self renderer:renderer pushObject:item request:nil source:nil];
    }
}

#pragma mark - Private methods

- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer pushObject:(id)object request:(ALPHARequest *)request source:(id<ALPHADataSource>)source
{
    //
    // Return here, we do not want to do anything further.
    //
    
    if ([object isKindOfClass:[ALPHAScreenItem class]] && [object object])
    {
        [self renderer:renderer pushObject:[(ALPHAScreenItem *)object object] request:nil source:source];
        
        return;
    }

    Class class = [self.converter renderClassForObject:object];
    
    //
    // Use renderer's source if available
    //
    
    if (!source)
    {
        source = renderer.source;
    }
    
    //
    // If not available create a new local source
    //
    
    if (!source)
    {
        source = [ALPHALocalSource new];
        [(ALPHALocalSource *)source loadSourcesFromPlugins:[ALPHAManager defaultManager].plugins];
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
            
            //
            // Redirect source if screen action item has it
            //
            
            if ([(ALPHAScreenActionItem *)object source])
            {
                source = [(ALPHAScreenActionItem *)object source];
            }
        }
        
        if (request)
        {
            [source dataForRequest:request completion:^(id newObject, NSError *error)
            {
                if (newObject)
                {
                    [self renderer:renderer pushObject:newObject request:request source:source];
                }
            }];
            
            return;
        }
    }
    
    id controller = nil;
    
    if ([class instancesRespondToSelector:@selector(initWithObject:)])
    {
        controller = [[class alloc] initWithObject:object];
    }
    else
    {
        controller = [[class alloc] init];
    }
    
    //
    // Forward data source
    //
    if ([controller respondsToSelector:@selector(setSource:)])
    {
        [controller setSource:source];
    }
    
    if ([controller respondsToSelector:@selector(setRequest:)] && request)
    {
        [controller setRequest:request];
    }
    
    if ([controller respondsToSelector:@selector(setObject:)] && ![object isKindOfClass:[ALPHARequest class]])
    {
        [controller setObject:object];
    }
    
    if (controller)
    {
        [self pushViewController:controller];
    }
}

//
// TODO: Add this as data renderer
//
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
