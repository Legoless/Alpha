//
//  ALPHAMainViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 8/5/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMainViewController.h"

#import "ALPHAMenuSource.h"
#import "ALPHABlockActionItem.h"

#import "ALPHAManager.h"

#import "ALPHACoreAssets.h"

#import "ALPHAExplorerMenu.h"

#import "ALPHAScreenManager.h"

@interface ALPHAMainViewController () <ALPHAViewControllerDelegate, ALPHAExplorerMenuDelegate>

//
// New properties
//

@property (nonatomic, strong) ALPHAExplorerMenu *explorerMenu;

@property (nonatomic, strong) NSArray *actions;

@property (nonatomic, strong) NSArray *actionImages;

@end

@implementation ALPHAMainViewController

#pragma mark - Getters and Setters

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.explorerMenu = [[ALPHAExplorerMenu alloc] initWithFrame:CGRectMake(0.0, 300.0, 60.0, 60.0)];
    self.explorerMenu.delegate = self;
    self.explorerMenu.snapToBorder = YES;
    
    self.explorerMenu.tintColor = [ALPHAManager defaultManager].theme.menuTintColor;
    self.explorerMenu.mainBackgroundColor = [ALPHAManager defaultManager].theme.menuBackgroundColor;
    self.explorerMenu.buttonBackgroundColor = [ALPHAManager defaultManager].theme.menuButtonBackgroundColor;
    self.explorerMenu.buttonSelectedBackgroundColor = [ALPHAManager defaultManager].theme.menuButtonSelectedBackgroundColor;
    self.explorerMenu.mainImage = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHALogoIdentifier color:nil size:CGSizeMake(34.0, 34.0)];
    
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
    NSMutableArray *actions = [NSMutableArray array];
    
    NSArray* plugins = [ALPHAManager defaultManager].plugins;
    
    for (ALPHAPlugin* plugin in plugins)
    {
        if (plugin.isEnabled)
        {
            for (ALPHAActionItem* action in plugin.actions)
            {
                if (action.isEnabled && [action.icon isKindOfClass:[UIImage class]] && [action isKindOfClass:[ALPHABlockActionItem class]])
                {
                    [actions addObject:action];
                }
            }
        }
    }
    NSSortDescriptor* prioritySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:YES];
    NSSortDescriptor* titleSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    
    self.actions = [actions sortedArrayUsingDescriptors:@[ prioritySortDescriptor, titleSortDescriptor ]];
    
    [actions removeAllObjects];
    
    for (ALPHAActionItem *action in self.actions)
    {
        [actions addObject:action.icon];
    }
    
    self.actionImages = actions.copy;
    
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

- (void)closeButtonTapped:(id)sender
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
