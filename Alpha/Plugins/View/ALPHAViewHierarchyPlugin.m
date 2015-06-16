//
//  ALPHAViewHierarchyPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"
#import "FLEXResources.h"

#import "ALPHAManager.h"

#import "ALPHAViewHierarchyPlugin.h"

#import "ALPHAViewHierarchySource.h"

#import "FLEXViewHierarchyViewController.h"

@interface ALPHAViewHierarchyPlugin () <ALPHAViewControllerDelegate>

@property (nonatomic, strong) FLEXViewHierarchyViewController* viewHierarchyViewController;

@end

@implementation ALPHAViewHierarchyPlugin

- (FLEXViewHierarchyViewController *)viewHierarchyViewController
{
    if (!_viewHierarchyViewController)
    {
        _viewHierarchyViewController = [[FLEXViewHierarchyViewController alloc] init];
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
        inspectAction.icon = [FLEXResources listIcon];
        inspectAction.actionBlock = ^id(id sender)
        {
            [[ALPHAManager sharedManager] addOverlayViewController:self.viewHierarchyViewController animated:YES completion:nil];
            
            return nil;
        };

        [self registerAction:inspectAction];
        
        //
        // Open views hierarchy
        //
        
        ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.viewHierarchy"];
        menuAction.title = @"View Hierarchy";
        menuAction.icon = @"💻";
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
    
    [[ALPHAManager sharedManager] removeOverlayViewController:self.viewHierarchyViewController];
}

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return [self.viewHierarchyViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}

@end
