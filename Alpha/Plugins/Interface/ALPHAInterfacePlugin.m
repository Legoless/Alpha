//
//  ALPHAInterfacePlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAManager.h"

#import "ALPHAMainViewController.h"

#import "ALPHABlockActionItem.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHAMenuSource.h"

#import "ALPHACoreAssets.h"

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
 *  @return Explorer View Controller instance
 */
- (UIViewController *)mainInterface
{
    return self.explorerViewController;
}

/*!
 *  Base plugin is the base of Alpha, cannot be disabled.
 *
 *  @return always YES
 */
- (BOOL)isEnabled
{
    return YES;
}

#pragma mark - Initialization

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.interface"];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        ALPHABlockActionItem *closeAction = [ALPHABlockActionItem itemWithIdentifier:ALPHAActionCloseIdentifier];
        closeAction.title = @"Close";
        closeAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconCloseIdentifier color:nil size:CGSizeMake(28.0, 28.0)];
        closeAction.priority = 6000.0;
        closeAction.actionBlock = ^id(id sender){
            [[ALPHAManager defaultManager] setInterfaceHidden:YES];
            
            return nil;
        };
        
        ALPHABlockActionItem *infoAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.info"];
        infoAction.title = @"Menu";
        infoAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconMenuIdentifier color:nil size:CGSizeMake(28.0, 28.0)];
        infoAction.priority = 5000.0;
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

#pragma mark - Plugin

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return [self.explorerViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}

#pragma mark - ALPHAViewControllerDelegate

- (void)viewControllerDidFinish:(UIViewController *)viewController
{
    [self finish];
}

- (void)finish
{
    [[ALPHAManager defaultManager] setHidden:YES];
}

@end
