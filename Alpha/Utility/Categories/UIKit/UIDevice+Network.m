//
//  UIDevice+Network.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "UIDevice+Network.h"

#import <SystemConfiguration/CaptiveNetwork.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>

#include <net/if.h>
#include <net/if_dl.h>

#include <ifaddrs.h>
#include <arpa/inet.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#import "UIDevice+Network.h"

@implementation UIDevice (Network)

- (NSString *)alpha_SSID {
    return [self fetchSSID][@"SSID"];
}

- (NSString *)alpha_BSSID {
    return [self fetchSSID][@"BSSID"];
}

- (NSString *)alpha_macAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    
    free(buf);
    
    return outstring;
}

- (NSDictionary *)alpha_localIPAddresses {
    NSMutableDictionary *localInterfaces = [NSMutableDictionary dictionary];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    
    if (!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for (interface = interfaces; interface; interface=interface->ifa_next) {
            if (!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if (addr && (addr->sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if (inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf)))
                {
                    
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    
                    localInterfaces[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [localInterfaces copy];
}

- (NSNumber *)alpha_receivedWiFi {
    return [[self networkDataCounters] objectAtIndex:1];
}

- (NSNumber *)alpha_receivedCellular {
    return [[self networkDataCounters] objectAtIndex:3];
}

- (NSNumber *)alpha_sentWifi {
    return [[self networkDataCounters] objectAtIndex:0];
}

- (NSNumber *)alpha_sentCellular {
    return [[self networkDataCounters] objectAtIndex:2];
}

#pragma mark - Private methods

- (NSDictionary *)fetchSSID {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    id info = nil;
    
    for (NSString *ifnam in ifs) {
        
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);

        if (info && [info count]) {
            break;
        }
    }
    
    return info;
}

- (NSArray *)networkDataCounters {
    BOOL success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatistics;
    
    u_int64_t WiFiSent = 0;
    u_int64_t WiFiReceived = 0;
    u_int64_t WWANSent = 0;
    u_int64_t WWANReceived = 0;
    
    NSString *name = nil;
    
    success = getifaddrs(&addrs) == 0;
    
    if (success) {
        cursor = addrs;
        
        while (cursor != NULL) {
            name = [NSString stringWithFormat:@"%s", cursor->ifa_name];
            
            if (cursor->ifa_addr->sa_family == AF_LINK) {
                if ([name hasPrefix:@"en"]) {
                    networkStatistics = (const struct if_data *) cursor->ifa_data;
                    WiFiSent += networkStatistics->ifi_obytes;
                    WiFiReceived += networkStatistics->ifi_ibytes;
                }
                
                if ([name hasPrefix:@"pdp_ip"]) {
                    networkStatistics = (const struct if_data *) cursor->ifa_data;
                    WWANSent += networkStatistics->ifi_obytes;
                    WWANReceived += networkStatistics->ifi_ibytes;
                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    return @[ @(WiFiSent), @(WiFiReceived), @(WWANSent), @(WWANReceived) ];
}

@end
