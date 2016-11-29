//
//  UIDevice+Software.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef enum : NSUInteger
{
    UIDeviceJailbreakStatusNotJailbroken,               // All tests passed
    UIDeviceJailbreakStatusPathExists,                  // Various paths exist
    UIDeviceJailbreakStatusCydia,                       // Cydia can be opened with URL scheme
    UIDeviceJailbreakStatusSandboxWrite,                // Can fork the process
    UIDeviceJailbreakStatusSymbolicLinkVerification,    // Symbolic links exist to applications
    UIDeviceJailbreakStatusPrivateWrite,                // Writes to a private folder (is it root?)
    UIDeviceJailbreakStatusShellExists,                 // SSH shell exists and is available
} UIDeviceJailbreakStatus;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Software)

/*!
 *  Returns YES if device is jailbroken after series of tests
 *
 *  @return YES if device is jailbroken
 */
- (BOOL)alpha_isJailbroken;

/*!
 *  Returns device jailbreak status after series of tests.
 *
 *  @return jailbreak status
 */
- (UIDeviceJailbreakStatus)alpha_jailbreakStatus;

/**
 *  Returns device boot date
 *
 *  @return device boot date
 */
- (NSDate *)alpha_systemBootDate;

//
// Process related information
//

- (NSArray *)alpha_processList;

- (NSUInteger)alpha_processCount;

- (float)alpha_cpuUsage;

@end
