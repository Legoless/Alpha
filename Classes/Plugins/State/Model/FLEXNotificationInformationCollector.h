//
//  FLEXNotificationInformationCollector.h
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXInformationCollector.h"

@interface FLEXNotificationInformationCollector : FLEXInformationCollector

/*!
 *  Contains string with enabled notification types
 */
@property (nonatomic, readonly) NSString* enabledNotificationTypes;

/*!
 *  Contains registered remote notification token
 */
@property (nonatomic, readonly) NSString* remoteNotificationToken;

@property (nonatomic, readonly) NSArray* localNotifications;

@end
