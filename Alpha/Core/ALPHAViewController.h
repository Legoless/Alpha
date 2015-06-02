//
//  ALPHAViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHACanvasView.h"

/*!
 *  Protocol to properly handle transitions between View Controllers
 */
@protocol ALPHAViewControllerDelegate <NSObject>

@optional

- (void)viewControllerDidFinish:(UIViewController *)viewController;

@end

/*!
 *  If View Controller responds to FLEX events, such as touches above all other windows
 */
@protocol ALPHAViewControllerResponder <NSObject>

- (BOOL)shouldReceiveTouchAtWindowPoint:(CGPoint)pointInWindowCoordinates;

@end

/*!
 *  View controller that is always active
 */
@interface ALPHAViewController : UIViewController <ALPHAViewControllerResponder>

@property (nonatomic, weak) id<ALPHAViewControllerDelegate> delegate;

/*!
 *  Wrapper property for view property if it is a type of FLEX Canvas view
 */
@property (nonatomic, readonly) ALPHACanvasView* canvasView;

- (UIViewController *)viewControllerForStatusBarAndOrientationProperties;

@end

