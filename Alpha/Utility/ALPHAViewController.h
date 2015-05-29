//
//  FLEXViewController.h
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXCanvasView.h"

/*!
 *  Protocol of a FLEXViewController, so finishing is properly handled
 */
@protocol FLEXViewControllerDelegate <NSObject>

@optional

- (void)viewControllerDidFinish:(UIViewController *)viewController;

@end

/*!
 *  If View Controller responds to FLEX events, such as touches above all other windows
 */
@protocol FLEXViewControllerResponder <NSObject>

- (BOOL)shouldReceiveTouchAtWindowPoint:(CGPoint)pointInWindowCoordinates;

@end

/*!
 *  View controller that is always active
 */
@interface ALPHAViewController : UIViewController <FLEXViewControllerResponder>

@property (nonatomic, weak) id<FLEXViewControllerDelegate> delegate;

/*!
 *  Wrapper property for view property if it is a type of FLEX Canvas view
 */
@property (nonatomic, readonly) FLEXCanvasView* canvasView;

- (UIViewController *)viewControllerForStatusBarAndOrientationProperties;

@end

