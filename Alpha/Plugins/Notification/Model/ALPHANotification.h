//
//  ALPHANotification.h
//  Alpha
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"
#import "ALPHAScreenRenderableItem.h"

@interface ALPHANotification : NSObject <ALPHASerializableItem>

@property (nonatomic, strong) NSDate* fireDate;
@property (nonatomic, strong) NSDate* receivedDate;
@property (nonatomic, copy) NSString *alertBody;
@property (nonatomic) BOOL hasAction;
@property (nonatomic, copy) NSString *alertAction;
@property (nonatomic, copy) NSString *alertLaunchImage;
@property (nonatomic, copy) NSString *soundName;
@property (nonatomic) NSInteger applicationIconBadgeNumber;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *category;

/**
 *  Set to YES if it is a remote notificaiton
 */
@property (nonatomic) BOOL isRemote;

/**
 *  Set to YES if called by fetch
 */
@property (nonatomic) BOOL isFetch;

+ (instancetype)notificationWithLocalNotification:(UILocalNotification *)localNotification;

+ (instancetype)notificationWithRemoteNotification:(NSDictionary *)userInfo;

- (ALPHAScreenItem *)screenItem;

@end
