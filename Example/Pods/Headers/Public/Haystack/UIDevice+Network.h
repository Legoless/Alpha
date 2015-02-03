//
//  UIDevice+Network.h
//

@import UIKit;

/*!
 * Category displays detailed information about current device hardware
 */
@interface UIDevice (Network)

- (NSString *)hs_SSID;

- (NSString *)hs_BSSID;

/**
 *  Returns MAC address of network adapter
 *
 *  @return MAC address in formatted shape
 */
- (NSString *)hs_macAddress;

/**
 *  Returns dictionary of local IP addresses, where key is the network interface
 *  and value is it's corresponding IP address.
 *
 *  @return dictionary of local IP addresses
 */
- (NSDictionary *)hs_localIPAddresses;

/**
 *  Returns number of bytes over WiFi
 *
 *  @return number of bytes
 */
- (NSNumber *)hs_receivedWiFi;

- (NSNumber *)hs_receivedCellular;

- (NSNumber *)hs_sentWifi;

- (NSNumber *)hs_sentCellular;

@end
