//
//  ALPHADeviceStatusCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Haystack/Haystack.h>
#import "FLEXUtility.h"

#import "UIDevice+ALPHAStatus.h"
#import "ALPHADeviceStatusCollector.h"
#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"

NSString* const ALPHADeviceStatusDataIdentifier = @"com.unifiedsense.alpha.data.status";

@interface ALPHADeviceStatusCollector ()

#warning Implement and check those properties

/*!
 *  Application memory size
 */
@property (nonatomic) long long applicationMemorySize;

/*!
 *  Size of application, including documents
 */
@property (nonatomic) long long applicationSandboxSize;

/*!
 *  Size of user related documents
 */
@property (nonatomic) long long applicationDocumentSize;

//
// System global
//

/*!
 *  Global available memory
 */
@property (nonatomic) long long systemMemorySize;

@property (nonatomic) long long systemDiskSpace;

@property (nonatomic) long long systemFreeDiskSpace;

@end

@implementation ALPHADeviceStatusCollector

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    });
    return dateFormatter;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHADeviceStatusDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)model
{
    //
    // Application section
    //
    
    NSDictionary* sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.application",
                                   @"items" : @[
                                         @{ @"Name" : [FLEXUtility applicationName] },
                                         @{ @"Version" : [[UIApplication sharedApplication] version] },
                                         @{ @"Build" : [[UIApplication sharedApplication] build] },
                                         @{ @"Build Date" : [NSString stringWithFormat:@"%@ - %@", [NSString stringWithUTF8String:__DATE__], [NSString stringWithUTF8String:__TIME__]] },
                                         @{ @"Bundle ID" : [[NSBundle mainBundle] bundleIdentifier] },
                                         @{ @"Badge Number" : @([UIApplication sharedApplication].applicationIconBadgeNumber) }
                                   ],
                                   @"style" : @(UITableViewCellStyleValue1),
                                   @"title" : @"Application" };
    
    ALPHAScreenSection* applicationSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    //
    // Usage section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.usage",
                     @"items" : @[
                             @{ @"Memory Size" : [NSByteCountFormatter stringFromByteCount:[UIApplication sharedApplication].memorySize countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Thread Count" : [NSString stringWithFormat:@"%lu", (unsigned long)[UIApplication sharedApplication].threadCount] },
                             @{ @"Process Count" : [NSString stringWithFormat:@"%lu", [UIDevice currentDevice].hs_processCount] },
                             @{ @"CPU Usage" : [NSString stringWithFormat:@"%lu%%", (unsigned long)([UIApplication sharedApplication].cpuUsage * 100.0)] }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"Usage" };

    
    ALPHAScreenSection* usageSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    //
    // System section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.system",
                     @"items" : @[
                             @{ @"System Version" : [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion] },

                             @{ @"System Time" : [self.dateFormatter stringFromDate:[NSDate date]] }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"System" };
    
    ALPHAScreenSection* systemSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    //
    // Locale section
    //
    
    NSMutableArray* items = [NSMutableArray array];
    
    NSArray* languages = [NSLocale preferredLanguages];
    
    for (NSString* language in languages)
    {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
        
        NSString* title = @"";
        
        if (!items.count)
        {
            title = @"User Languages";
        }
        
        [items addObject:@{ title : [locale displayNameForKey:NSLocaleIdentifier value:language] }];
    }
    
    NSString* region = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
    
    [items addObjectsFromArray:@[
        @{ @"Timezone" : [NSTimeZone localTimeZone].name },
        @{ @"Region" : [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:region] },
        @{ @"Calendar" : [[[[NSLocale currentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier] capitalizedString] }
    ]];
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.system",
                     @"items" : items.copy,
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"Locale" };
    
    ALPHAScreenSection* localeSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];

    
    //
    // Device section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.device",
                     @"items" : @[
                             @{ @"Model" : [UIDevice currentDevice].modelName },
                             @{ @"Identifier" : [UIDevice currentDevice].modelIdentifier },
                             @{ @"CPU Count" : [NSString stringWithFormat:@"%lu", (unsigned long)([UIDevice currentDevice].hs_cpuPhysicalCount)] },
                             @{ @"CPU Type" : [UIDevice currentDevice].hs_cpuType },
                             @{ @"Architectures" : [UIDevice currentDevice].hs_cpuArchitectures },
                             @{ @"Total Memory" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_memoryMarketingSize countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Available Memory" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_memoryPhysicalSize countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Capacity" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_diskMarketingSpace countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Total Capacity" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_diskTotalSpace countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Free Capacity" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_diskFreeSpace countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Jailbroken" : @([UIDevice currentDevice].hs_jailbreakStatus != UIDeviceJailbreakStatusNotJailbroken) }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"Device" };
    
    
    ALPHAScreenSection* deviceSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    //
    // IP Addresses section
    //
    
    items = [NSMutableArray array];
    
    NSDictionary* ipInfo = [UIDevice currentDevice].hs_localIPAddresses;
    
    for (NSString* key in ipInfo)
    {
        [items addObject:@{ [NSString stringWithFormat:@"IP (%@)", key] : ipInfo[key] }];
    }
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.network",
                     @"items" : items.copy,
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"Local IP Addresses" };
    
    
    ALPHAScreenSection* ipSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    //
    // Network section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.network",
                     @"items" : @[
                             @{ @"MAC Address" : [UIDevice currentDevice].hs_macAddress },
                             @{ @"SSID" : [UIDevice currentDevice].hs_SSID },
                             @{ @"BSSDID" : [UIDevice currentDevice].hs_BSSID },
                             @{ @"Received Wi-Fi" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_receivedWiFi.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Sent Wi-Fi" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_sentWifi.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Received Cellular" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_receivedCellular.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Sent Cellular" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_sentCellular.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"Network" };
    
    
    ALPHAScreenSection* networkSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    #warning Add other data from Core Telephony (phone number, etc, ...)
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.cellular",
                     @"items" : @[
                             @{ @"Carrier" : [UIDevice currentDevice].alpha_carrierName }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"title" : @"Cellular" };
    
    
    ALPHAScreenSection* cellularSection = [ALPHAScreenSection dataSectionWithDictionary:sectionData];
    
    //
    // Data model
    //
    
    ALPHAScreenModel* dataModel = [[ALPHAScreenModel alloc] initWithIdentifier:ALPHADeviceStatusDataIdentifier];
    dataModel.title = @"Status";
    dataModel.sections = @[ applicationSection, usageSection, systemSection, localeSection, deviceSection, ipSection, networkSection, cellularSection ];
    
    // Data model expires in 0.5 seconds
    dataModel.expiration = 0.5;
    
    return dataModel;
}

@end
