//
//  ALPHAInterfacePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAManager.h"

#import "ALPHAMainViewController.h"

#import "ALPHABlockActionItem.h"
#import "ALPHAMenuActionItem.h"
#import "ALPHAMenuDataCollector.h"
#import "FLEXResources.h"

#import "ALPHAGlobalActionIdentifiers.h"

#import "ALPHAInterfacePlugin.h"

@interface ALPHAInterfacePlugin () <ALPHAViewControllerDelegate>

@property (nonatomic, strong) ALPHAMainViewController* explorerViewController;

@end

@implementation ALPHAInterfacePlugin

#pragma mark - Getters and Setters

- (ALPHAMainViewController *)explorerViewController
{
    if (!_explorerViewController)
    {
        _explorerViewController = [[ALPHAMainViewController alloc] init];
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
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.base"];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        ALPHABlockActionItem *closeAction = [ALPHABlockActionItem itemWithIdentifier:ALPHAActionCloseIdentifier];
        closeAction.title = @"Close";
        closeAction.icon = [FLEXResources closeIcon];
        closeAction.actionBlock = ^(id sender){
            [[ALPHAManager sharedManager] setInterfaceHidden:YES];
        };
        
        ALPHABlockActionItem *infoAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.info"];
        infoAction.title = @"Info";
        infoAction.icon = [FLEXResources globeIcon];
        infoAction.actionBlock = ^(id sender){
            [self.explorerViewController displayInfoTable];
        };
        
        [self registerAction:infoAction];
        [self registerAction:closeAction];
        
        //
        // Base view controllers
        //
        
        [self registerMenuActions];
        
        //
        // Data Collectors
        //
        
        [self registerCollector:[ALPHAMenuDataCollector new]];
    }
    
    return self;
}

- (void)registerMenuActions
{
    //
    // Those actions are basically legacy from vanilla FLEX version and should be refactored.
    //
    ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.globalState"];
    menuAction.title = @"Global State";
    menuAction.icon = @"🌍";
    menuAction.viewControllerClass = @"FLEXGlobalsTableViewController";
    [self registerAction:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.memoryHeap"];
    menuAction.icon = @"💩";
    menuAction.title = @"Heap Objects";
    menuAction.viewControllerClass = @"FLEXLiveObjectsTableViewController";
    [self registerAction:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.fileBrowser"];
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
    [[ALPHAManager sharedManager] setHidden:YES];
}

@end
