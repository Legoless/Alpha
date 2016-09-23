//
//  ALPHATCC.h
//  Alpha
//
//  Created by Dal Rupnik on 18/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

int TCCAccessRequest(NSString *service, NSString *message, int completion); // Triggers permission request
int TCCAccessPreflight(NSString *service); // Checks for permission settings
int TCCAccessRestricted(NSString *service); //

//
// Methods for system processes
//
// Note: calling them on a non-privileged process will emit a notice in OS console:
//  tccd[102] <Notice>: Refusing <Method name> from unprivileged client (pid <PID>)
//
/*int TCCAccessCheckAuditToken(int a1, char a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10);
int TCCAccessCopyInformation(NSString* service, SEL a2); // This one is called by Preferences
int TCCAccessCopyInformationInternal(int a1);
int TCCAccessCopyInformationForBundle(NSString *bundleIdentifier);
int TCCAccessCopyBundleIdentifiersForService(int a1);
int TCCAccessCopyBundleIdentifiersDisabledForService(int a1);
int TCCAccessSetOverride(int a1, char a2);
int TCCAccessSetForBundle(NSString *service, CFBundleRef bundle, BOOL access); // This is called by Preferences
int TCCAccessSetInternal(int a1, int a2, int a3, int a4, char a5);
int TCCAccessSet(int a1, int a2, char a3);
int TCCAccessSetForPath(int a1, int a2, int a3, char a4);
int TCCAccessSetForAuditToken(int a1, int a2, char a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, char a11);
int TCCAccessOverride(int a1, char a2);
int TCCAccessGetOverride(int a1, int a2); // This is called by Preferences to get value
int TCCAccessReset(int a1);
int TCCAccessResetForBundle(int a1, int a2);
int TCCAccessResetForPath(int a1, int a2);
int TCCAccessResetInternal(int a1, int a2, int a3);
int TCCAccessDeclarePolicy(int a1, int a2);
int TCCAccessSelectPolicyForExtensionWithIdentifier(int a1, int a2);
int TCCAccessResetPoliciesExcept(int a1);
int TCCTestInternal(int a1, int a2, int a3);

// Sends to daemon
int tccd(void); // weak
int tccd_send(int a1, int a2, int a3);*/
