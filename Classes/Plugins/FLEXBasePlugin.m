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

/**
 *  Returns explorer view controller as the main interface
 *
 *  @return FLEX Explorer View Controller
 */
- (UIViewController *)mainInterface
{
    return self.explorerViewController;
}

- (BOOL)isEnabled
{
    return YES;
}

#pragma mark - Initializers

- (id)init
{
    self = [super init];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        FLEXActionItem *closeAction = [FLEXActionItem actionItemWithIdentifier:@"com.flex.close"];
        closeAction.title = @"Close";
        closeAction.image = [FLEXResources closeIcon];
        closeAction.action = ^(id sender){
            [[FLEXManager sharedManager] hideExplorer];
        };
        closeAction.enabled = YES;
        
        FLEXActionItem *infoAction = [FLEXActionItem actionItemWithIdentifier:@"com.flex.info"];
        infoAction.title = @"Info";
        infoAction.image = [FLEXResources globeIcon];
        infoAction.action = ^(id sender){
            [self.explorerViewController displayInfoTable];
        };
        infoAction.enabled = YES;
        
        [self registerAction:infoAction];
        [self registerAction:closeAction];
    }
    
    return self;
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
    [[FLEXManager sharedManager] hideExplorer];
}

@end
