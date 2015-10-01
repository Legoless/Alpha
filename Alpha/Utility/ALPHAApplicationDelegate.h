//
//  ALPHAApplicationDelegate.h
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMockObject.h"

@import UIKit;

/*!
 *  Sign up to this notification if you like to receive NSInvocation objects for application delegate events
 */
extern NSString *const ALPHAApplicationDelegateNotification;

/*!
 *  Alpha application mock object
 */
@interface ALPHAApplicationDelegate : ALPHAMockObject <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*!
 *  Designated initializer to setup Alpha system with original application delegate
 *
 *  @param delegate original delegate
 *
 *  @return instance of application delegate
 */
- (instancetype)initWithDelegate:(id<UIApplicationDelegate>)delegate;

@end
