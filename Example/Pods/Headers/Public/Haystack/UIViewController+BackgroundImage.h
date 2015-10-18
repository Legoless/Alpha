//
//  UIViewController+BackgroundImage.h
//

@import UIKit;

/*!
 * Category for UIViewController which enables us to set it BackgroundImage
 */
@interface UIViewController (BackgroundImage)

/*!
 * Sets background image to UIViewController.
 *
 * @param image which will be used as background
 */
- (void)hay_setBackgroundImage:(UIImage *)image;

/*!
 * Sets background image to UIViewController.
 *
 * @param image which will be used as background
 * @param YES if animated property
 */
- (void)hay_setBackgroundImage:(UIImage *)image animated:(BOOL)animated;

/*!
 * Returns background image for navigation controller if set, nil otherwise.
 *
 * @return UIImage background image for navigation controller
 */
- (UIImage *)hay_backgroundImage;

/*!
 * Returns background image view for direct access to image view in navigation controller.
 */
- (UIImageView *)hay_backgroundImageView;

@end
