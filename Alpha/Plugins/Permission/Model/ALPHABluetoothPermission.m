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

@property (nonatomic, strong) CBCentralManager *centralManager;

@end

@implementation ALPHABluetoothPermission

#pragma mark - Getters and Setters

- (CBCentralManager *)centralManager
{
    if (!_centralManager)
    {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:nil queue:nil];
    }
    
    return _centralManager;
}

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.bluetooth"];
}

#pragma mark - Public Methods

- (ALPHAApplicationAuthorizationStatus)status
{
    switch (self.centralManager.state)
    {
        case CBCentralManagerStateUnsupported:
            return ALPHAApplicationAuthorizationStatusUnsupported;
        case CBCentralManagerStateUnauthorized:
            return ALPHAApplicationAuthorizationStatusDenied;
        default:
            return ALPHAApplicationAuthorizationStatusNotDetermined;
    }
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    
}

@end
