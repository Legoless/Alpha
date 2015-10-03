//
//  ALPHAEventPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAEventPermission.h"

@interface ALPHAEventPermission ()

@property (nonatomic, strong) EKEventStore* eventStore;

@end

@implementation ALPHAEventPermission

#pragma mark - Getters and Setters

- (EKEventStore *)eventStore
{
    if (!_eventStore)
    {
        _eventStore = [[EKEventStore alloc] init];
    }
    
    return _eventStore;
}

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.calendar"];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    return (ALPHAApplicationAuthorizationStatus)[EKEventStore authorizationStatusForEntityType:self.entityType];
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    [self.eventStore requestAccessToEntityType:self.entityType completion:^(BOOL granted, NSError * _Nullable error)
    {
        if (completion)
        {
            completion (self, (granted) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, error);
        }
    }];
}

- (NSString *)name
{
    return self.entityType == EKEntityTypeEvent ? @"Calendar" : @"Reminders";
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

#pragma mark - Private Methods

@end
