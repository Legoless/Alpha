//
//  FLEXBasePlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXManager.h"

#import "FLEXExplorerViewController.h"
#import "FLEXInfoTableViewController.h"

#import "FLEXActionItem.h"
#import "FLEXMenuItem.h"
#import "FLEXResources.h"

#import "FLEXBasePlugin.h"

@interface FLEXBasePlugin () <FLEXViewControllerDelegate>

@property (nonatomic, strong) FLEXExplorerViewController* explorerViewController;

@end

@implementation FLEXBasePlugin

#pragma mark - Getters and Setters

- (FLEXExplorerViewController *)explorerViewController
{
    if (!_explorerViewController)
    {
        _explorerViewController = [[FLEXExplorerViewController alloc] init];
        _explorerViewController.delegate = self;
    }
    
    return _explorerViewController;
}

/*!
 *  Returns explorer view controller as the main interface
 *
 *  @return FLEX Explorer View Controller
 */
- (UIViewController *)mainInterface
{
    return self.explorerViewController;
}

/*!
 *  Base plugin is the base of FLEX, cannot be disabled.
 *
 *  @return always YES
 */
- (BOOL)isEnabled
{
    return YES;
}

#pragma mark - Initializers

- (id)init
{
    self = [super initWithIdentifier:@"com.flex.base"];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        FLEXActionItem *closeAction = [FLEXActionItem itemWithIdentifier:@"com.flex.close"];
        closeAction.title = @"Close";
        closeAction.icon = [FLEXResources closeIcon];
        closeAction.action = ^(id sender){
            [[FLEXManager sharedManager] setHidden:YES];
        };
        
        FLEXActionItem *infoAction = [FLEXActionItem itemWithIdentifier:@"com.flex.info"];
        infoAction.title = @"Info";
        infoAction.icon = [FLEXResources globeIcon];
        infoAction.action = ^(id sender){
            [self.explorerViewController displayInfoTable];
        };
        
        [self registerAction:infoAction];
        [self registerAction:closeAction];
        
        //
        // Base view controllers
        //
        
        [self registerMenuActions];
    }
    
    return self;
}

- (void)registerMenuActions
{
    //
    // Those actions are basically legacy from vanilla FLEX version and should be refactored.
    //
    FLEXMenuItem* menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.globalState"];
    menuAction.title = @"Global State";
    menuAction.icon = @"🌍";
    menuAction.viewControllerClass = @"FLEXGlobalsTableViewController";
    [self registerAction:menuAction];
    
    menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.memoryHeap"];
    menuAction.icon = @"💩";
    menuAction.title = @"Heap Objects";
    menuAction.viewControllerClass = @"FLEXLiveObjectsTableViewController";
    [self registerAction:menuAction];
    
    menuAction = [FLEXMenuItem itemWithIdentifier:@"com.flex.fileBrowser"];
    menuAction.icon = @"📁";
    menuAction.title = @"File Browser";
    menuAction.viewControllerClass = @"FLEXFileBrowserTableViewController";
    [self registerAction:menuAction];
}

#pragma mark - FLEXPlugin

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return [self.explorerViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}

#pragma mark - FLEXExplorerViewControllerDelegate

- (void)viewControllerDidFinish:(UIViewController *)viewController
{
    [self finish];
}

- (void)finish
{
    [[FLEXManager sharedManager] setHidden:YES];
}

@end
