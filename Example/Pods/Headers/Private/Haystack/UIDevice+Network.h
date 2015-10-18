//
//  UIDevice+Network.h
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Network)

- (NSString *)hay_SSID;

- (NSString *)hay_BSSID;

/**
 *  Returns MAC address of network adapter
 *
 *  @return MAC address in formatted shape
 */
- (NSString *)hay_macAddress;

/**
 *  Returns dictionary of local IP addresses, where key is the network interface
 *  and value is it's corresponding IP address.
 *
 *  @return dictionary of local IP addresses
 */
- (NSDictionary *)hay_localIPAddresses;

/**
 *  Returns number of bytes over WiFi
 *
 *  @return number of bytes
 */
- (NSNumber *)hay_receivedWiFi;

- (NSNumber *)hay_receivedCellular;

- (NSNumber *)hay_sentWifi;

- (NSNumber *)hay_sentCellular;

@end
