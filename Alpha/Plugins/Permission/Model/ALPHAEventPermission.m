//
//  ALPHAEventPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEventPermission.h"

@implementation ALPHAEventPermission

#pragma mark - Initialization

- (NSString *)name
{
    return self.entityType == EKEntityTypeEvent ? @"Calendar" : @"Reminders";
}

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.calendar"];
}

- (ALPHAApplicationAuthorizationStatus)status
{
    return (ALPHAApplicationAuthorizationStatus)[EKEventStore authorizationStatusForEntityType:self.entityType];
}

+ (NSArray *)allPermissions
{
    return @[ [self new], [self reminderPermission] ];
}

+ (ALPHAPermission *)reminderPermission
{
    ALPHAEventPermission* eventPermission = [[ALPHAEventPermission alloc] initWithIdentifier:@"com.unifiedsense.alpha.data.reminder"];
    eventPermission.entityType = EKEntityTypeReminder;
    
    return eventPermission;
}

@end
