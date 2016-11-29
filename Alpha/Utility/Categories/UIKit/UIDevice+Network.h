//
//  UIDevice+Network.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Network)

- (NSString *)alpha_SSID;

- (NSString *)alpha_BSSID;

/**
 *  Returns MAC address of network adapter
 *
 *  @return MAC address in formatted shape
 */
- (NSString *)alpha_macAddress;

/**
 *  Returns dictionary of local IP addresses, where key is the network interface
 *  and value is it's corresponding IP address.
 *
 *  @return dictionary of local IP addresses
 */
- (NSDictionary *)alpha_localIPAddresses;

/**
 *  Returns number of bytes over WiFi
 *
 *  @return number of bytes
 */
- (NSNumber *)alpha_receivedWiFi;

- (NSNumber *)alpha_receivedCellular;

- (NSNumber *)alpha_sentWifi;

- (NSNumber *)alpha_sentCellular;

@end
