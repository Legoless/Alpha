//
//  FLEXStatusTableViewController.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>
#import "FLEXUtility.h"

#import "FLEXStatusTableViewController.h"

@interface FLEXStatusTableViewController ()

//
// Application related information
//

/**
 *  Application memory size
 */

@property (nonatomic) long long applicationMemorySize;

/**
 *  Size of application, including documents
 */
@property (nonatomic) long long applicationSandboxSize;

/**
 *  Size of user related documents
 */
@property (nonatomic) long long applicationDocumentSize;

/**
 *  Currently active threads
 */
@property (nonatomic) int threadCount;

//
// System global
//

/**
 *  Global available memory
 */
@property (nonatomic) long long systemMemorySize;

@property (nonatomic) long long systemDiskSpace;

@property (nonatomic) long long systemFreeDiskSpace;

@property (nonatomic) double cpuUsage;

@property (nonatomic) int processCount;

//
// Update timer
//

@property (nonatomic, strong) NSTimer* refreshTimer;

@end

@implementation FLEXStatusTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStyleGrouped;
    
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.title = @"Status";
        self.refreshRate = 0.5;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:self.refreshRate target:self selector:@selector(refreshData) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}

- (void)refreshData
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    else if (section == 1)
    {
        return 3;
    }
    else if (section == 2)
    {
        return 2;
    }
    else if (section == 3)
    {
        return 10;
    }
    else if (section == 4)
    {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.detailTextLabel.minimumScaleFactor = 0.5;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsLetterSpacingToFitWidth = YES;
    }
    
    //cell.textLabel.attributedText = [self titleForRowAtIndexPath:indexPath];
    //cell.detailTextLabel.attributedText = [self subtitleForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        [self updateCell:cell forApplicationAtIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        [self updateCell:cell forStatsAtIndexPath:indexPath];
    }
    else if (indexPath.section == 2)
    {
        [self updateCell:cell forSystemAtIndexPath:indexPath];
    }
    else if (indexPath.section == 3)
    {
        [self updateCell:cell forDeviceAtIndexPath:indexPath];
    }
    else if (indexPath.section == 4)
    {
        [self updateCell:cell forNetworkAtIndexPath:indexPath];
    }
    
    return cell;
}

- (void)updateCell:(UITableViewCell *)cell forApplicationAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = [FLEXUtility applicationName];
            
            break;
        case 1:
            cell.textLabel.text = @"Version";
            cell.detailTextLabel.text = [[UIApplication sharedApplication] version];
            
            break;
        case 2:
            cell.textLabel.text = @"Build";
            cell.detailTextLabel.text = [[UIApplication sharedApplication] build];
            
            break;
        case 3:
            cell.textLabel.text = @"Build Date";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [NSString stringWithUTF8String:__DATE__], [NSString stringWithUTF8String:__TIME__]];
            
            break;
        case 4:
            cell.textLabel.text = @"Bundle ID";
            cell.detailTextLabel.text = [[NSBundle mainBundle] bundleIdentifier];
            
            break;

        default:
            break;
    }
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
            cell.textLabel.text = @"System Processes";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", [UIDevice currentDevice].hs_processCount];
            
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
            cell.textLabel.text = @"MAC Address";
            cell.detailTextLabel.text = [UIDevice currentDevice].hs_macAddress;
            
            break;
        default:
            break;
    }
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Application";
    }
    else if (section == 1)
    {
        return @"Usage";
    }
    else if (section == 2)
    {
        return @"System";
    }
    else if (section == 3)
    {
        return @"Device";
    }
    else if (section == 4)
    {
        return @"Network";
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
