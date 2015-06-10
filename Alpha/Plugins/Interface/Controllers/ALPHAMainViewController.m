//
//  ALPHAMainViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 8/5/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMainViewController.h"
#import "FLEXExplorerToolbar.h"
#import "FLEXToolbarItem.h"
#import "FLEXUtility.h"
#import "FLEXHierarchyTableViewController.h"
#import "FLEXObjectExplorerViewController.h"
#import "FLEXObjectExplorerFactory.h"

#import "ALPHAMenuSource.h"
#import "ALPHABlockActionItem.h"
#import "ALPHANavigationController.h"

#import "ALPHACanvasView.h"

#import "ALPHATableDataRendererViewController.h"
#import "ALPHAManager.h"
#import "ALPHAPlugin.h"

#import "ALPHAExplorerMenu.h"

#import "ALPHAViewController.h"
#import "ALPHALocalSource.h"

#import "ALPHAScreenManager.h"

@interface ALPHAMainViewController () <ALPHAViewControllerDelegate, ALPHAExplorerMenuDelegate>

//
// New properties
//

@property (nonatomic, strong) ALPHAExplorerMenu *explorerMenu;

@property (nonatomic, strong) NSMutableArray *actions;

@property (nonatomic, strong) NSMutableArray *actionImages;

@end

@implementation ALPHAMainViewController

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
	
    self.explorerMenu = [[ALPHAExplorerMenu alloc] initWithFrame:CGRectMake(0.0, 300.0, 60.0, 60.0)];
    self.explorerMenu.delegate = self;
    self.explorerMenu.snapToBorder = YES;
    
    self.explorerMenu.circleBackgroundColor = [[ALPHAManager sharedManager].theme.backgroundColor colorWithAlphaComponent:0.8];
    self.explorerMenu.circleActiveBackgroundColor = [ALPHAManager sharedManager].theme.highlightedBackgroundColor;
    
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
    
    NSArray* plugins = [ALPHAManager sharedManager].plugins;
    
    for (ALPHAPlugin* plugin in plugins)
    {
        if (plugin.isEnabled)
        {
            for (ALPHAActionItem* action in plugin.actions)
            {
                if (action.isEnabled && [action.icon isKindOfClass:[UIImage class]] && [action isKindOfClass:[ALPHABlockActionItem class]])
                {
                    [self.actions addObject:action];
                    [self.actionImages addObject:action.icon];
                }
            }
        }
    }
    
    self.explorerMenu.images = [self.actionImages copy];
}

#pragma mark - ALPHAExplorerMenuDelegate

- (void)explorerMenu:(ALPHAExplorerMenu *)explorerMenu didSelectImage:(UIImage *)image
{
    ALPHABlockActionItem* action = [self actionForImage:image];
    
    //
    // Run action with explorer menu as sender
    //
    
    if (action.actionBlock)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^
        {
            action.actionBlock(explorerMenu);
        });
    }
}

- (ALPHABlockActionItem *)actionForImage:(UIImage *)image
{
    for (ALPHAActionItem *action in self.actions)
    {
        if (action.icon == image && [action isKindOfClass:[ALPHABlockActionItem class]])
        {
            return (ALPHABlockActionItem *)action;
        }
    }
    
    return nil;
}

- (void)displayInfoTable
{
    [[ALPHAScreenManager defaultManager] pushObject:[ALPHARequest requestWithIdentifier:ALPHAMenuDataIdentifier]];
}

- (void)closeButtonTapped:(FLEXToolbarItem *)sender
{
    [self close];
}

- (void)close;
{
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
    if (!shouldReceiveTouch && self.presentedViewController)
    {
        shouldReceiveTouch = YES;
    }
    
    return shouldReceiveTouch;
}

@end
