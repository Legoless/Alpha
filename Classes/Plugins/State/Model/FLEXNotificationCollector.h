//
//  FLEXNotificationInformationCollector.h
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXSystemNotification.h"

#import "FLEXInformationCollector.h"

@interface FLEXNotificationCollector : FLEXInformationCollector

/*!
 *  Contains string with enabled notification types
 */
@property (nonatomic, readonly) NSString* enabledNotificationTypes;

/*!
 *  Contains registered remote notification token
 */
@property (nonatomic, strong) NSString* remoteNotificationToken;


@property (nonatomic, readonly) NSArray* remoteNotifications;

@property (nonatomic, readonly) NSArray* localNotifications;

- (void)registerRemoteNotification:(FLEXSystemNotification *)notification;

@end
