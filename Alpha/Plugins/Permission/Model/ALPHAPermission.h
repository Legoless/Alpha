//
//  ALPHAPermission.h
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

@class ALPHAPermission;

typedef enum : NSUInteger {
    ALPHAApplicationAuthorizationStatusNotDetermined,
    ALPHAApplicationAuthorizationStatusRestricted,
    ALPHAApplicationAuthorizationStatusDenied,
    ALPHAApplicationAuthorizationStatusAuthorized,
    ALPHAApplicationAuthorizationStatusUnsupported,
    ALPHAApplicationAuthorizationStatusAskAgain,
    ALPHAApplicationAuthorizationStatusDoNotAskAgain,
    ALPHAApplicationAuthorizationStatusMissingFramework
} ALPHAApplicationAuthorizationStatus;

typedef void (^ALPHAPermissionRequestCompletion)(ALPHAPermission* permission, ALPHAApplicationAuthorizationStatus status, NSError* error);

NSString* NSStringFromAuthorizationStatus (ALPHAApplicationAuthorizationStatus status);

@interface ALPHAPermission : NSObject

/*!
 *  Status of permission
 */
@property (nonatomic, readonly) ALPHAApplicationAuthorizationStatus status;

/*!
 *  Required for network to work
 */
@property (nonatomic, copy, readonly) NSString *identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

/*!
 *  Requests permission from system
 *
 *  @param completion called when done
 */
- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion;

/*!
 *  Resets permission to original state
 *
 *  @param completion called when done
 */
- (void)resetPermission:(void (^)(BOOL success))completion;

/*!
 *  Factory method that returns all permissions for a specific class
 *
 *  @return all permission for specific permission
 */
+ (NSArray *)allPermissions;

/*!
 *  Converts permission into status string, this should be called for displaying type on screen.
 *
 *  @return string
 */
- (NSString *)statusString;

/*!
 *  Returns permission name
 *
 *  @return name
 */
- (NSString *)name;

@end
