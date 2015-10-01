//
//  ALPHANotificationModel.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"

@interface ALPHANotificationModel : ALPHAModel

/*!
 *  Contains string with enabled notification types that
 */
@property (nonatomic, copy) NSString* enabledNotificationTypes;

/*!
 *  Contains registered remote notification token
 */
@property (nonatomic, copy) NSString* remoteNotificationToken;

/*!
 *  Holds remote registration description based on register calls
 */
@property (nonatomic, copy) NSString* remoteRegistrationDescription;

/*!
 *  Received remote notifications
 */
@property (nonatomic, copy) NSArray* remoteNotifications;

/*!
 *  Currently scheduled local notifications
 */
@property (nonatomic, copy) NSArray* scheduledLocalNotifications;

/*!
 *  Already fired local notifications
 */
@property (nonatomic, copy) NSArray* firedLocalNotifications;

@end
