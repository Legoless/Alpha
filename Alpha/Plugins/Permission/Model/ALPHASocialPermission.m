//
//  ALPHASocialPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Accounts;

#import "NSString+Identifier.h"

#import "ALPHASocialPermission.h"

@interface ALPHASocialPermission ()

@property (nonatomic, strong) ACAccountType *accountType;
@property (nonatomic, strong) ACAccountStore *accountStore;

@end

@implementation ALPHASocialPermission

#pragma mark - Getters and Setters

- (ACAccountType *)accountType
{
    if (!_accountType)
    {
        _accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:self.identifier];
    }
    
    return _accountType;
}

- (ACAccountStore *)accountStore
{
    if (!_accountStore)
    {
        _accountStore = [ACAccountStore new];
    }
    
    return _accountStore;
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    return self.accountType.accessGranted ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied;
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    [self.accountStore requestAccessToAccountsWithType:self.accountType options:nil completion:^(BOOL granted, NSError *error)
    {
        if (completion)
        {
            completion (self, (granted) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, error);
        }
    }];
}

- (NSString *)name
{
    return [[[self.identifier componentsSeparatedByString:@"."] lastObject] capitalizedString];
}

+ (NSArray *)allPermissions
{
    return @[
        [[ALPHASocialPermission alloc] initWithIdentifier:ACAccountTypeIdentifierTwitter],
        [[ALPHASocialPermission alloc] initWithIdentifier:ACAccountTypeIdentifierFacebook],
        [[ALPHASocialPermission alloc] initWithIdentifier:ACAccountTypeIdentifierSinaWeibo],
        [[ALPHASocialPermission alloc] initWithIdentifier:ACAccountTypeIdentifierTencentWeibo]
        //[[ALPHASocialPermission alloc] initWithIdentifier:ACAccountTypeIdentifierLinkedIn]
    ];
}

@end
