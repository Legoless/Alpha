//
//  ALPHAContactPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Contacts;
@import AddressBook;

#import "ALPHAContactPermission.h"

@implementation ALPHAContactPermission

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.contact"];
}

#pragma mark - Public Methods

- (NSString *)name
{
    return @"Contacts";
}

- (ALPHAApplicationAuthorizationStatus)status
{
    if ([self useContactsFramework])
    {
        return (ALPHAApplicationAuthorizationStatus)[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized;
    }
    else
    {
        return (ALPHAApplicationAuthorizationStatus)ABAddressBookGetAuthorizationStatus();
    }
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    if ([self useContactsFramework])
    {
        [self requestContactsPermissionWithCompletion:^(BOOL granted, NSError *error)
        {
            if (completion)
            {
                completion (self, (granted) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, error);
            }
        }];
    }
    else
    {
        [self requestAddressBookPermissionWithCompletion:^(BOOL granted, NSError *error)
        {
            if (completion)
            {
                completion (self, (granted) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, error);
            }
        }];
    }
}

#pragma mark - Private Methods

- (BOOL)useContactsFramework
{
    return [[CNContactStore alloc] init] != nil;
}

- (void)requestAddressBookPermissionWithCompletion:(void (^)(BOOL granted, NSError *error))completion
{
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef err)
    {
        NSError *error = (__bridge NSError *)err;

        if (completion)
        {
            completion(granted, error);
        }
    });
}

- (void)requestContactsPermissionWithCompletion:(void (^)(BOOL granted, NSError *error))completion
{
    CNContactStore *store = [[CNContactStore alloc] init];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error)
    {
        if (completion)
        {
            completion(granted, error);
        }
    }];
}

@end
