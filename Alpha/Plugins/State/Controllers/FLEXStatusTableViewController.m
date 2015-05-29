//
//  FLEXStatusTableViewController.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>
#import "UIDevice+Status.h"

#import "FLEXUtility.h"
#import "ALPHAModel.h"

#import "FLEXStatusTableViewController.h"

@interface FLEXStatusTableViewController ()

//
// Application related information
//

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

//
// Update timer
//

#warning ADD APPLICATION BADGE, NETWORK INFORMATION, JAILBREAK INFORMATION, ...


@end

@implementation FLEXStatusTableViewController

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStyleGrouped;
    
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.title = @"Status";
        self.refreshRate = 0.5;
        
        [self buildModel];
    }
    
    return self;
}

- (void)buildModel
{
    
    ALPHADisplaySection* usageSection = [[ALPHADisplaySection alloc] initWithTitle:@"Usage"];
    ALPHADisplaySection* systemSection = [[ALPHADisplaySection alloc] initWithTitle:@"System"];
    ALPHADisplaySection* deviceSection = [[ALPHADisplaySection alloc] initWithTitle:@"Device"];
    ALPHADisplaySection* networkSection = [[ALPHADisplaySection alloc] initWithTitle:@"Network"];
    
    // Section created from dictionary
    
    NSDictionary* appSection = @{ @"Application" : @[
                                  @{ @"Name" : [FLEXUtility applicationName] },
                                  @{ @"Version" : [[UIApplication sharedApplication] version] },
                                  @{ @"Build" : [[UIApplication sharedApplication] build] },
                                  @{ @"Build Date" : [NSString stringWithFormat:@"%@ - %@", [NSString stringWithUTF8String:__DATE__], [NSString stringWithUTF8String:__TIME__]] },
                                  @{ @"Bundle ID" : [[NSBundle mainBundle] bundleIdentifier] }
                               ] };
    
    ALPHADisplaySection* applicationSection = [ALPHADisplaySection displaySectionWithDictionary:appSection];
}

- (void)updateCell:(UITableViewCell *)cell forStatsAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Memory Size";
            cell.detailTextLabel.text = [NSByteCountFormatter stringFromByteCount:[UIApplication sharedApplication].memorySize countStyle:NSByteCountFormatterCountStyleBinary];
            
            break;
        case 1:
            cell.textLabel.text = @"Thread Count";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[UIApplication sharedApplication].threadCount];
            
            break;
        case 2:
            cell.textLabel.text = @"CPU Usage";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu%%", (unsigned long)([UIApplication sharedApplication].cpuUsage * 100.0)];
            
            break;

        default:
            break;
    }
}

- (void)updateCell:(UITableViewCell *)cell forSystemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"System Version";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
            
            break;
        case 1:
            cell.textLabel.text = @"Process Count";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", [UIDevice currentDevice].hs_processCount];
            
            break;
        case 2:
        {
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            NSString *currentTime = [dateFormatter stringFromDate:today];
            
            cell.textLabel.text = @"System Time";
            cell.detailTextLabel.text = currentTime;
            
            break;
        }
        case 3:
            cell.textLabel.text = @"Timezone";
            cell.detailTextLabel.text = [NSTimeZone localTimeZone].name;
            
            break;
        case 4:
        {
            NSArray *languages = [NSLocale preferredLanguages];
            
            cell.textLabel.text = @"System Languages";

            cell.detailTextLabel.text = [languages componentsJoinedByString:@", "];
            
            break;
        }
        case 5:
        {
            cell.textLabel.text = @"Region";
            
            NSString* identifier = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
            cell.detailTextLabel.text = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            
            break;
        }
        case 6:
            cell.textLabel.text = @"Calendar";
            cell.detailTextLabel.text = [[[NSLocale currentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier];
            
            break;
        default:
            break;
    }
}

- (void)updateCell:(UITableViewCell *)cell forDeviceAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Model";
            cell.detailTextLabel.text = [UIDevice currentDevice].modelName;
            
            break;
        case 1:
            cell.textLabel.text = @"Identifier";
            cell.detailTextLabel.text = [UIDevice currentDevice].modelIdentifier;
            
            break;
        case 2:
            cell.textLabel.text = @"CPU Count";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)([UIDevice currentDevice].hs_cpuPhysicalCount)];
            
            break;
        case 3:
            cell.textLabel.text = @"CPU Type";
            cell.detailTextLabel.text = [UIDevice currentDevice].hs_cpuType;
            
            break;
        case 4:
            cell.textLabel.text = @"Architectures";
            cell.detailTextLabel.text = [UIDevice currentDevice].hs_cpuArchitectures;
            
            break;
        case 5:
            cell.textLabel.text = @"Total Memory";
            cell.detailTextLabel.text = [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_memoryMarketingSize countStyle:NSByteCountFormatterCountStyleBinary];
            
            break;
        case 6:
            cell.textLabel.text = @"Available Memory";
            cell.detailTextLabel.text = [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_memoryPhysicalSize countStyle:NSByteCountFormatterCountStyleBinary];
            
            break;
        case 7:
            cell.textLabel.text = @"Capacity";
            cell.detailTextLabel.text = [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_diskMarketingSpace countStyle:NSByteCountFormatterCountStyleBinary];
            
            break;
        case 8:
            cell.textLabel.text = @"Total Capacity";
            cell.detailTextLabel.text = [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_diskTotalSpace countStyle:NSByteCountFormatterCountStyleBinary];
            
            break;
        case 9:
            cell.textLabel.text = @"Free Capacity";
            cell.detailTextLabel.text = [NSByteCountFormatter stringFromByteCount:[UIDevice currentDevice].hs_diskFreeSpace countStyle:NSByteCountFormatterCountStyleBinary];
            
            break;
        default:
            break;
    }
}

- (void)updateCell:(UITableViewCell *)cell forNetworkAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Carrier";
            cell.detailTextLabel.text = [UIDevice currentDevice].alpha_serviceProvider;
            
            break;
        case 1:
            cell.textLabel.text = @"MAC Address";
            cell.detailTextLabel.text = [UIDevice currentDevice].hs_macAddress;
            
            break;
        default:
            break;
    }
}*/

@end
