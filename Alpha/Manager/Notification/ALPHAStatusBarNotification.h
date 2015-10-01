//
//  ALPHAStatusBarNotification.h
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void(^ALPHACompletionBlock)(void);

/*!
 *  Status bar notification to display
 */
@interface ALPHAStatusBarNotification : NSObject

@property (nonatomic, readonly) UILabel *notificationLabel;
@property (nonatomic, readonly) UIView *customView;

@property (assign, nonatomic) CGFloat notificationLabelHeight;

@property (copy, nonatomic) ALPHACompletionBlock notificationTappedBlock;

@property (nonatomic, readonly) BOOL isShowing;
@property (nonatomic, readonly) BOOL isDismissing;

- (void)displayNotificationWithMessage:(NSString *)message forDuration:(CGFloat)duration;
- (void)displayNotificationWithMessage:(NSString *)message completion:(void (^)(void))completion;
- (void)displayNotificationWithView:(UIView *)view forDuration:(CGFloat)duration;
- (void)displayNotificationWithView:(UIView *)view completion:(void (^)(void))completion;
- (void)dismissNotification;
- (void)dismissNotificationWithCompletion:(void(^)(void))completion;

@end
