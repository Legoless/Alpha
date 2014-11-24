//
//  FLEXViewHierarchyPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXActionItem.h"
#import "FLEXResources.h"

#import "FLEXManager.h"

#import "FLEXViewHierarchyPlugin.h"

#import "FLEXViewHierarchyViewController.h"

@interface FLEXViewHierarchyPlugin () <FLEXViewControllerDelegate>

@property (nonatomic, strong) FLEXViewHierarchyViewController* viewHierarchyViewController;

@end

@implementation FLEXViewHierarchyPlugin

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
    self = [super init];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        FLEXActionItem *inspectAction = [FLEXActionItem actionItemWithIdentifier:@"com.flex.view.inspect"];
        inspectAction.title = @"Inspect";
        inspectAction.image = [FLEXResources listIcon];
        inspectAction.action = ^(id sender){
            [[FLEXManager sharedManager] addChildViewControllerToRootViewController:self.viewHierarchyViewController animated:YES completion:nil];
            //[[FLEXManager sharedManager].explorerWindow addSubview:self.viewHierarchyViewController.view];
            
            //[self.viewHierarchyViewController displayHierarchyExplorer];
        };
        inspectAction.enabled = YES;

        [self registerAction:inspectAction];
    }
    
    return self;
}

- (void)viewControllerDidFinish:(UIViewController *)viewController
{
    //
    // Close was tapped on child view controller, we should remove the view controller from children
    //
    
    [[FLEXManager sharedManager] removeChildViewController:self.viewHierarchyViewController];
}

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    return [self.viewHierarchyViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}

@end
