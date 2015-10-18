//
//  UIDevice+Software.h
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
- (BOOL)hay_isJailbroken;

/*!
 *  Returns device jailbreak status after series of tests.
 *
 *  @return jailbreak status
 */
- (UIDeviceJailbreakStatus)hay_jailbreakStatus;

/**
 *  Returns device boot date
 *
 *  @return device boot date
 */
- (NSDate *)hay_systemBootDate;

//
// Process related information
//

- (NSArray *)hay_processList;

- (NSUInteger)hay_processCount;

- (float)hay_cpuUsage;

@end
