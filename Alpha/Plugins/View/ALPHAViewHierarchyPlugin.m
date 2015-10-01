//
//  ALPHAViewHierarchyPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"

#import "ALPHAManager.h"

#import "ALPHAViewHierarchyPlugin.h"

#import "ALPHAViewHierarchySource.h"

#import "ALPHAViewHierarchyViewController.h"

#import "ALPHAAssetManager.h"
#import "ALPHAViewIcon.h"

@interface ALPHAViewHierarchyPlugin () <ALPHAViewControllerDelegate>

@property (nonatomic, strong) ALPHAViewHierarchyViewController * viewHierarchyViewController;

@end

@implementation ALPHAViewHierarchyPlugin

- (ALPHAViewHierarchyViewController *)viewHierarchyViewController
{
    if (!_viewHierarchyViewController)
    {
        _viewHierarchyViewController = [[ALPHAViewHierarchyViewController alloc] init];
        _viewHierarchyViewController.delegate = self;
    }
    
    return _viewHierarchyViewController;
}

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.viewHierarchy"];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        ALPHABlockActionItem *inspectAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.view.inspect"];
        inspectAction.title = @"Inspect";
        inspectAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconViewIdentifier color:nil size:CGSizeMake(28.0, 28.0)];
        inspectAction.priority = 4000.0;
        inspectAction.actionBlock = ^id(id sender)
        {
            [[ALPHAManager defaultManager] addOverlayViewController:self.viewHierarchyViewController animated:YES completion:nil];
            
            return nil;
        };

        [self registerAction:inspectAction];
        
        //
        // Open views hierarchy
        //
        
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.viewHierarchy"];
        menuAction.title = @"View Hierarchy";
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconViewIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.dataIdentifier = ALPHAViewDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Source
        //
        
        [self registerSource:[ALPHAViewHierarchySource new]];
    }
    
    return self;
}

- (void)viewControllerDidFinish:(UIViewController *)viewController
{
    //
    // Close was tapped on child view controller, we should remove the view controller from children
    //
    
    [[ALPHAManager defaultManager] removeOverlayViewController:self.viewHierarchyViewController];
}

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return [self.viewHierarchyViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}

@end
