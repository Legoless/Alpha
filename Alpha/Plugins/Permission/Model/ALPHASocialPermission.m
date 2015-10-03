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

- (NSString *)name
{
    return [[[self.identifier componentsSeparatedByString:@"."] lastObject] capitalizedString];
}

- (ALPHAApplicationAuthorizationStatus)status
{
    return self.accountType.accessGranted ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied;
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
