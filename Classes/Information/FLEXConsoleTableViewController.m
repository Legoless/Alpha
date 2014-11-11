//
//  FLEXConsoleTableViewController.m
//  UICatalog
//
//  Created by Dal Rupnik on 11/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXConsoleInformationCollector.h"
#import "FLEXObjectExplorerFactory.h"
#import "FLEXObjectExplorerViewController.h"
#import "FLEXConsoleLog.h"
#import "FLEXUtility.h"

#import "FLEXConsoleTableViewController.h"

@interface FLEXConsoleTableViewController ()

@property (nonatomic, strong) NSArray *logs;

@end

@implementation FLEXConsoleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.title = @"Console";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.logs = [[FLEXConsoleInformationCollector sharedCollector].logs copy];
}

#pragma mark - Table view data source

- (NSAttributedString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXConsoleLog *consoleLog = self.logs[indexPath.row];
    
    NSString *string = [NSString stringWithFormat:@"● %@", consoleLog.message];
    
    UIFont *font = [FLEXUtility defaultTableViewCellLabelFont];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:string attributes:@{ NSFontAttributeName : font }];
    
    //
    // Get the color correct of status
    //
    
    if (consoleLog.level < 4)
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:231.0 / 255.0 green:76.0 / 255.0 blue:60.0 / 255.0 alpha:1.0], NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0] } range:NSMakeRange(0, 1)];
        
    }
    else if (consoleLog.level < 6)
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:241.0 / 255.0 green:196.0 / 255.0 blue:15.0 / 255.0 alpha:1.0], NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0] } range:NSMakeRange(0, 1)];
    }
    else
    {
        [title addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:52.0 / 255.0 green:152.0 / 255.0 blue:219.0 / 255.0 alpha:1.0], NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0] } range:NSMakeRange(0, 1)];
    }
    
    //
    // Bold the method
    //
    
    [title addAttributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:font.pointSize] } range:NSMakeRange(2, consoleLog.message.length)];
    
    return title;
}

- (NSAttributedString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXConsoleLog *consoleLog = self.logs[indexPath.row];
    
    NSMutableString *detailString = [[NSMutableString alloc] init];
    
    [detailString appendFormat:@"%@ %@[%@:%@]", consoleLog.localTime, consoleLog.sender, consoleLog.PID, consoleLog.ASLMessageID];
    
    UIFont *font = [FLEXUtility defaultTableViewCellLabelFont];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:detailString attributes:@{ NSFontAttributeName : [font fontWithSize:10.0] }];
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.logs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.attributedText = [self titleForRowAtIndexPath:indexPath];
    cell.detailTextLabel.attributedText = [self subtitleForRowAtIndexPath:indexPath];
    
    return cell;
}

- (UIViewController *)viewControllerToPushForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXConsoleLog *consoleLog = self.logs[indexPath.row];
    
    return [FLEXObjectExplorerFactory explorerViewControllerForObject:consoleLog];
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewControllerToPush = [self viewControllerToPushForRowAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}


@end
