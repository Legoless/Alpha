//
//  FLEXExplorerViewController.m
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXExplorerViewController.h"
#import "FLEXExplorerToolbar.h"
#import "FLEXToolbarItem.h"
#import "FLEXUtility.h"
#import "FLEXHierarchyTableViewController.h"
#import "FLEXInfoTableViewController.h"
#import "FLEXObjectExplorerViewController.h"
#import "FLEXObjectExplorerFactory.h"

#import "FLEXActionItem.h"

#import "FLEXCanvasView.h"

#import "FLEXPluginManager.h"
#import "FLEXManager.h"
#import "FLEXPlugin.h"

#import "FLEXExplorerMenu.h"

#import "FLEXViewController.h"

@interface FLEXExplorerViewController () <FLEXViewControllerDelegate, FLEXExplorerMenuDelegate>

//
// New properties
//

@property (nonatomic, strong) FLEXExplorerMenu *explorerMenu;

@property (nonatomic, strong) NSMutableArray *actions;

@property (nonatomic, strong) NSMutableArray *actionImages;

@end

@implementation FLEXExplorerViewController

#pragma mark - Getters and Setters

- (NSMutableArray *)actions
{
    if (!_actions)
    {
        _actions = [NSMutableArray array];
    }
    
    return _actions;
}

- (NSMutableArray *)actionImages
{
    if (!_actionImages)
    {
        _actionImages = [NSMutableArray array];
    }
    
    return _actionImages;
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.explorerMenu = [[FLEXExplorerMenu alloc] initWithFrame:CGRectMake(0.0, 300.0, 60.0, 60.0)];
    self.explorerMenu.delegate = self;
    self.explorerMenu.snapToBorder = YES;
    
    //
    // Disable touches for canvas view, we do not care about other shit
    //
    
    self.canvasView.shouldReceiveTouches = NO;
    
    [self.view addSubview:self.explorerMenu];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateActions];
}

/*!
 *  Builds action list from plugins
 */
- (void)updateActions
{
    [self.actions removeAllObjects];
    [self.actionImages removeAllObjects];
    
    NSArray* plugins = [FLEXPluginManager sharedManager].plugins;
    
    for (FLEXPlugin* plugin in plugins)
    {
        if (plugin.isEnabled)
        {
            for (FLEXActionItem* action in plugin.actions)
            {
                if (action.isEnabled && [action.icon isKindOfClass:[UIImage class]] && [action isMemberOfClass:[FLEXActionItem class]])
                {
                    [self.actions addObject:action];
                    [self.actionImages addObject:action.icon];
                }
            }
        }
    }
    
    self.explorerMenu.images = [self.actionImages copy];
}

#pragma mark - FLEXExplorerMenuDelegate

- (void)explorerMenu:(FLEXExplorerMenu *)explorerMenu didSelectImage:(UIImage *)image
{
    FLEXActionItem* action = [self actionForImage:image];
    
    //
    // Run action with explorer menu as sender
    //
    
    if (action.action)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^
        {
            action.action(explorerMenu);
        });
    }
}

- (FLEXActionItem *)actionForImage:(UIImage *)image
{
    for (FLEXActionItem *action in self.actions)
    {
        if (action.icon == image)
        {
            return action;
        }
    }
    
    return nil;
}

- (void)displayInfoTable
{
    FLEXInfoTableViewController *globalsViewController = [[FLEXInfoTableViewController alloc] init];
    globalsViewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:globalsViewController];
    [[FLEXManager sharedManager] makeKeyAndPresentViewController:navigationController animated:YES completion:nil];
}

- (void)closeButtonTapped:(FLEXToolbarItem *)sender
{
    [self close];
}

- (void)close;
{
    //self.currentMode = FLEXExplorerModeDefault;
    //[self.delegate explorerViewControllerDidFinish:self];
    
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}
#pragma mark - Touch Handling

- (BOOL)shouldReceiveTouchAtWindowPoint:(CGPoint)pointInWindowCoordinates
{
    BOOL shouldReceiveTouch = NO;
    
    CGPoint pointInLocalCoordinates = [self.view convertPoint:pointInWindowCoordinates fromView:nil];
    
    if (CGRectContainsPoint(self.explorerMenu.frame, pointInLocalCoordinates))
    {
        shouldReceiveTouch = YES;
    }
    
    // Always if we have a modal presented
    if (!shouldReceiveTouch && self.presentedViewController) {
        shouldReceiveTouch = YES;
    }
    
    return shouldReceiveTouch;
}

#pragma mark - FLEXViewControllerDelegate

- (void)viewControllerDidFinish:(UIViewController *)viewController
{
    /*if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }*/
    
    //
    // A child view controller has finished, remove it.
    //
    
    [[FLEXManager sharedManager] resignKeyAndDismissViewControllerAnimated:YES completion:nil];
}

@end
