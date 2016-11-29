//
//  ALPHATCCPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 23/09/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "ALPHATCC.h"
#import "ALPHATCCAccessManager.h"
#import "ALPHATCCPermission.h"

@interface ALPHATCCPermission ()

@end

@implementation ALPHATCCPermission

- (NSString *)name {
    //
    // TCC Permissions have a different naming convention.
    //
    
    return [NSString stringWithFormat:@"TCC %@", [self.identifier stringByReplacingOccurrencesOfString:@"kTCCService" withString:@""]];
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion {
    /*
    void *block = (__bridge void *)(^{
        completion(self, self.status, nil);
    });*/
    
    int access = TCCAccessRequest(self.identifier, @"Alpha is requesting permission", 0);
    
    NSLog(@"Access: %d", access);
}

- (ALPHAApplicationAuthorizationStatus)status {
    int access = TCCAccessPreflight(self.identifier);
    
    NSLog(@"Access: %d", access);
    
    return access;
}

+ (NSArray *)allPermissions {
    NSMutableArray* allPermissions = [NSMutableArray array];
    
    NSArray *identifiers = [ALPHATCCAccessManager accessIdentifiers];
    
    for (NSString* identifier in identifiers) {
        ALPHATCCPermission *permission = [[ALPHATCCPermission alloc] initWithIdentifier:identifier];
        [allPermissions addObject:permission];
    }
    
    return allPermissions.copy;
}

@end
