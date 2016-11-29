//
//  ALPHADeviceStatusCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import CoreTelephony;

#import "NSString+Data.h"
#import "UIApplication+Information.h"
#import "UIApplication+Version.h"

#import "UIDevice+DeviceInfo.h"
#import "UIDevice+Hardware.h"
#import "UIDevice+Software.h"
#import "UIDevice+Network.h"

#import "ALPHARuntimeUtility.h"

#import "ALPHAUtility.h"

#import "UIDevice+ALPHAStatus.h"
#import "ALPHADeviceStatusSource.h"
#import "ALPHAModel.h"
#import "ALPHATableScreenModel.h"

extern NSString* CTSettingCopyMyPhoneNumber();

NSString* const ALPHADeviceStatusDataIdentifier = @"com.unifiedsense.alpha.data.status";

@interface ALPHADeviceStatusSource ()

@end

@implementation ALPHADeviceStatusSource

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
        
        [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    NSMutableArray* items = [NSMutableArray array];
    
    //
    // Application section
    //
    
    NSDictionary* sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.application",
                                   @"items" : @[
                                         @{ @"Name" : [ALPHARuntimeUtility applicationName] },
                                         @{ @"Version" : [[UIApplication sharedApplication] alpha_version] },
                                         @{ @"Build" : [[UIApplication sharedApplication] alpha_build] },
                                         @{ @"Build Date" : [NSString stringWithFormat:@"%@ - %@", [NSString stringWithUTF8String:__DATE__], [NSString stringWithUTF8String:__TIME__]] },
                                         @{ @"Bundle ID" : [[NSBundle mainBundle] bundleIdentifier] },
                                         @{ @"Badge Number" : [@([UIApplication sharedApplication].applicationIconBadgeNumber) stringValue] }
                                   ],
                                   @"style" : @(UITableViewCellStyleValue1),
                                   @"headerText" : @"Application" };
    
    ALPHAScreenSection* applicationSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    //
    // Usage section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.usage",
                     @"items" : @[
                             @{ @"Memory Size" : [NSByteCountFormatter stringFromByteCount:[UIApplication sharedApplication].alpha_memorySize countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Documents Size" : [self sizeOfFolder: [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]] },
                             @{ @"Sandbox Size" : [self sizeOfFolder:NSHomeDirectory()] },
                             @{ @"Thread Count" : [NSString stringWithFormat:@"%lu", (unsigned long)[UIApplication sharedApplication].alpha_threadCount] },
                             @{ @"Process Count" : [NSString stringWithFormat:@"%lu", (unsigned long)[UIDevice currentDevice].alpha_processCount] },
                             @{ @"CPU Usage" : [NSString stringWithFormat:@"%lu%%", (unsigned long)([UIApplication sharedApplication].alpha_cpuUsage * 100.0)] }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"Usage" };

    
    ALPHAScreenSection* usageSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    //
    // System section
    //
    
    [items removeAllObjects];
    [items addObjectsFromArray:@[
        @{ @"System Version" : [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion] },
        @{ @"System Time" : [self.dateFormatter stringFromDate:[NSDate date]] },
        @{ @"Low Power Mode" : ALPHAEncodeBool([[NSProcessInfo processInfo] isLowPowerModeEnabled]) }
    ]];
    
    NSArray *keyboards = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] objectForKey:@"AppleKeyboards"];;
    
    for (NSString* keyboard in keyboards)
    {
        NSString* title = @"";
        
        if (items.count <= 3)
        {
            title = @"User Keyboards";
        }
        
        [items addObject:@{ title : keyboard }];
    }
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.system",
                     @"items" : items.copy,
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"System" };
    
    ALPHAScreenSection* systemSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    //
    // Locale section
    //
    
    [items removeAllObjects];
    
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
                     @"headerText" : @"Locale" };
    
    ALPHAScreenSection* localeSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];

    
    //
    // Device section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.device",
                     @"items" : @[
                             @{ @"Name" : [UIDevice currentDevice].name },
                             @{ @"Model" : [UIDevice currentDevice].alpha_modelName },
                             @{ @"Identifier" : [UIDevice currentDevice].alpha_modelIdentifier },
                             @{ @"CPU Count" : [NSString stringWithFormat:@"%lu", (unsigned long)([UIDevice currentDevice].alpha_cpuPhysicalCount)] },
                             @{ @"CPU Type" : [UIDevice currentDevice].alpha_cpuType },
                             @{ @"Architectures" : [UIDevice currentDevice].alpha_cpuArchitectures },
                             @{ @"Total Memory" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_memoryMarketingSize countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Available Memory" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_memoryPhysicalSize countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Capacity" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_diskMarketingSpace countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Total Capacity" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_diskTotalSpace countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Free Capacity" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_diskFreeSpace countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Jailbroken" : ALPHAEncodeBool([UIDevice currentDevice].alpha_jailbreakStatus != UIDeviceJailbreakStatusNotJailbroken) },
                             @{ @"Battery level" : [NSString stringWithFormat:@"%ld%%", (long)([UIDevice currentDevice].batteryLevel * 100)] }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"Device" };

    ALPHAScreenSection* deviceSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    //
    // IP Addresses section
    //
    
    items = [NSMutableArray array];
    
    NSDictionary* ipInfo = [UIDevice currentDevice].alpha_localIPAddresses;
    
    for (NSString* key in ipInfo)
    {
        [items addObject:@{ [NSString stringWithFormat:@"IP (%@)", key] : ipInfo[key] }];
    }
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.network",
                     @"items" : items.copy,
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"Local IP Addresses" };
    
    
    ALPHAScreenSection* ipSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    //
    // Network section
    //
    
    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.network",
                     @"items" : @[
                             @{ @"MAC Address" : ALPHAEncodeString([UIDevice currentDevice].alpha_macAddress) },
                             @{ @"SSID" : ALPHAEncodeString([UIDevice currentDevice].alpha_SSID) },
                             @{ @"BSSDID" : ALPHAEncodeString([UIDevice currentDevice].alpha_BSSID) },
                             @{ @"Received Wi-Fi" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_receivedWiFi.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Sent Wi-Fi" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_sentWifi.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Received Cellular" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_receivedCellular.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] },
                             @{ @"Sent Cellular" : [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].alpha_sentCellular.longLongValue countStyle:NSByteCountFormatterCountStyleBinary] }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"Network" };
    
    
    ALPHAScreenSection* networkSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    CTTelephonyNetworkInfo* info = [[CTTelephonyNetworkInfo alloc] init];

    sectionData = @{ @"identifier" : @"com.unifiedsense.alpha.data.status.cellular",
                     @"items" : @[
                             @{ @"Carrier" : [UIDevice currentDevice].alpha_carrierName },
                             @{ @"Carrier Name" : ALPHAEncodeString([info.subscriberCellularProvider.carrierName capitalizedString]) },
                             @{ @"Data Connection": ALPHAEncodeString([self radioTypeFromRadioAccessTechnology:info.currentRadioAccessTechnology]) },
                             @{ @"Country Code" : ALPHAEncodeString(info.subscriberCellularProvider.mobileCountryCode) },
                             @{ @"Network Code" : ALPHAEncodeString(info.subscriberCellularProvider.mobileNetworkCode) },
                             @{ @"ISO Country Code" : ALPHAEncodeString(info.subscriberCellularProvider.isoCountryCode) },
                             @{ @"VoIP Enabled" : ALPHAEncodeBool(info.subscriberCellularProvider.allowsVOIP) }
                     ],
                     @"style" : @(UITableViewCellStyleValue1),
                     @"headerText" : @"Cellular" };
    
    
    ALPHAScreenSection* cellularSection = [ALPHAScreenSection screenSectionWithDictionary:sectionData];
    
    //
    // Data model
    //
    
    ALPHATableScreenModel* dataModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHADeviceStatusDataIdentifier];
    dataModel.title = @"Status";
    dataModel.tableViewStyle = UITableViewStyleGrouped;
    
    dataModel.sections = @[ applicationSection, usageSection, systemSection, localeSection, deviceSection, ipSection, networkSection, cellularSection ];
    
    // Data model expires in 0.5 seconds
    dataModel.expiration = 0.5;
    
    return dataModel;
}

#pragma mark - Private Methods

- (NSString *)sizeOfFolder:(NSString *)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long int folderSize = 0;
    
    while (file = [contentsEnumurator nextObject])
    {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    
    //This line will give you formatted size from bytes ....
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

- (NSString *)radioTypeFromRadioAccessTechnology:(NSString *)radioAccess
{
    return [radioAccess stringByReplacingOccurrencesOfString:@"CTRadioAccessTechnology" withString:@""];
}

@end
