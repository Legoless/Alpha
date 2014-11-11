//
//  FLEXSystemNotification.h
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "JSONModel.h"

@interface FLEXSystemNotification : JSONModel

@property (nonatomic, copy) NSDate* fireDate;
@property (nonatomic, copy) NSString *alertBody;
@property (nonatomic) BOOL hasAction;
@property (nonatomic, copy) NSString *alertAction;
@property (nonatomic, copy) NSString *alertLaunchImage;
@property (nonatomic, copy) NSString *soundName;
@property (nonatomic) NSInteger applicationIconBadgeNumber;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *category;

+ (instancetype)systemNotificationWithLocalNotification:(UILocalNotification *)notification;

@end
