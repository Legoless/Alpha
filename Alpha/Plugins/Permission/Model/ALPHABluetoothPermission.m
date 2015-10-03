//
//  ALPHABluetoothPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import CoreBluetooth;

#import "ALPHABluetoothPermission.h"

@interface ALPHABluetoothPermission ()

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@end

@implementation ALPHABluetoothPermission

#pragma mark - Getters and Setters

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.bluetooth"];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    return (ALPHAApplicationAuthorizationStatus)[CBPeripheralManager authorizationStatus];
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    if (self.peripheralManager == nil)
    {
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:nil];
    }
    
    if (completion)
    {
        completion(self, self.status, nil);
    }
}

@end
