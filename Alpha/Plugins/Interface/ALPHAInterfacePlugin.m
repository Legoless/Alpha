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
#import "ALPHAScreenActionItem.h"
#import "ALPHAMenuSource.h"
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
        closeAction.actionBlock = ^id(id sender){
            [[ALPHAManager sharedManager] setInterfaceHidden:YES];
            
            return nil;
        };
        
        ALPHABlockActionItem *infoAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.info"];
        infoAction.title = @"Info";
        infoAction.icon = [FLEXResources globeIcon];
        infoAction.actionBlock = ^id(id sender){
            [self.explorerViewController displayInfoTable];
            
            return nil;
        };
        
        [self registerAction:infoAction];
        [self registerAction:closeAction];
        
        //
        // Data Sources
        //
        
        [self registerSource:[ALPHAMenuSource new]];
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
    [[ALPHAManager sharedManager] setHidden:YES];
}

@end
