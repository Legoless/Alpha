//
//  ALPHAApplicationDelegate.h
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAMockObject.h"

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
