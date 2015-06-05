//
//  ALPHAViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMainViewController.h"
#import "FLEXExplorerToolbar.h"
#import "FLEXToolbarItem.h"
#import "FLEXUtility.h"
#import "FLEXHierarchyTableViewController.h"
#import "FLEXObjectExplorerViewController.h"
#import "FLEXObjectExplorerFactory.h"

#import "ALPHAActionItem.h"

#import "ALPHAManager.h"
#import "ALPHAPlugin.h"

#import "ALPHACanvasView.h"

#import "ALPHAExplorerMenu.h"

#import "ALPHAViewController.h"

@interface ALPHAViewController ()

//
// New properties
//

/*
@property (nonatomic, strong) FLEXExplorerMenu *explorerMenu;

@property (nonatomic, strong) NSMutableArray *actions;

@property (nonatomic, strong) NSMutableArray *actionImages;
*/
@end

@implementation ALPHAViewController

- (ALPHACanvasView *)canvasView
{
    if ([self.view isKindOfClass:[ALPHACanvasView class]])
    {
        return (ALPHACanvasView *)self.view;
    }
    
    return nil;
}

#pragma mark - ALPHACanvasView to ignore touches

/*
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}*/

- (void)loadView
{
    [self setup];
}

- (void)setup
{
    //
    // Replace main view with Canvas view
    //
    ALPHACanvasView* canvasView = [[ALPHACanvasView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = canvasView;
}

#pragma mark - Status Bar Wrangling for iOS 7

// Try to get the preferred status bar properties from the app's root view controller (not us).
// In general, our window shouldn't be the key window when this view controller is asked about the status bar.
// However, we guard against infinite recursion and provide a reasonable default for status bar behavior in case our window is the keyWindow.

- (UIViewController *)viewControllerForStatusBarAndOrientationProperties
{
    UIViewController *viewControllerToAsk = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    // On iPhone, modal view controllers get asked
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        while (viewControllerToAsk.presentedViewController) {
            viewControllerToAsk = viewControllerToAsk.presentedViewController;
        }
    }
    
    return viewControllerToAsk;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    UIStatusBarStyle preferredStyle = UIStatusBarStyleDefault;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        // We might need to foward to a child
        UIViewController *childViewControllerToAsk = [viewControllerToAsk childViewControllerForStatusBarStyle];
        while (childViewControllerToAsk && childViewControllerToAsk != viewControllerToAsk) {
            viewControllerToAsk = childViewControllerToAsk;
            childViewControllerToAsk = [viewControllerToAsk childViewControllerForStatusBarStyle];
        }
        
        preferredStyle = [viewControllerToAsk preferredStatusBarStyle];
    }
    return preferredStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    UIStatusBarAnimation preferredAnimation = UIStatusBarAnimationFade;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        preferredAnimation = [viewControllerToAsk preferredStatusBarUpdateAnimation];
    }
    return preferredAnimation;
}

- (BOOL)prefersStatusBarHidden
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    BOOL prefersHidden = NO;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        // Again, we might need to forward to a child
        UIViewController *childViewControllerToAsk = [viewControllerToAsk childViewControllerForStatusBarHidden];
        while (childViewControllerToAsk && childViewControllerToAsk != viewControllerToAsk) {
            viewControllerToAsk = childViewControllerToAsk;
            childViewControllerToAsk = [viewControllerToAsk childViewControllerForStatusBarHidden];
        }
        
        prefersHidden = [viewControllerToAsk prefersStatusBarHidden];
    }
    return prefersHidden;
}

#pragma mark - Touch Handling

- (BOOL)shouldReceiveTouchAtWindowPoint:(CGPoint)pointInWindowCoordinates
{
    return NO;
}

@end
