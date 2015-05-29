//
//  FLEXScreenshotTableViewController.m
//  UICatalog
//
//  Created by Dal Rupnik on 18/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Haystack/Haystack.h>

#import "FLEXScreenshotTableViewController.h"
#import "FLEXImagePreviewViewController.h"
#import "FLEXUtility.h"
#import "ALPHAWindow.h"
#import "ALPHAFileManager.h"

@interface FLEXScreenshotTableViewController ()

@property (nonatomic, copy) NSArray *screenshots;

@property (nonatomic, strong) NSDateFormatter* fileDateFormatter;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@end

@implementation FLEXScreenshotTableViewController

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateStyle = NSDateFormatterFullStyle;
        _dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    }
    
    return _dateFormatter;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self){
        self.title = @"Screenshots";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadScreenshots];
}

- (void)loadScreenshots
{
    NSError* error;
    
    NSString *directory = [NSString stringWithFormat:@"%@FLEX/Screenshots", [[ALPHAFileManager sharedManager] documentsDirectory].absoluteString];
    self.screenshots = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL URLWithString:directory] includingPropertiesForKeys:@[] options:0 error:&error];
    
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.screenshots count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [FLEXUtility defaultTableViewCellLabelFont];
    }
    
    NSURL *path = self.screenshots[indexPath.row];
    
    NSString* filename = [path.pathComponents lastObject];
    
    filename = [filename stringByReplacingOccurrencesOfString:@"FLEX_SS_" withString:@""];
    filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:@""];
    
    NSDate *date = [[ALPHAFileManager sharedManager].fileDateFormatter dateFromString:filename];
    
    NSString *text = [self.dateFormatter stringFromDate:date];
    
    if (!text.length)
    {
        text = [path.pathComponents lastObject];
    }
    
    cell.textLabel.text = text;
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData* data = [NSData dataWithContentsOfURL:self.screenshots[indexPath.row]];

    UIImage *image = [UIImage imageWithData:data];
    
    UIViewController *viewControllerToPush = [[FLEXImagePreviewViewController alloc] initWithImage:image];
    
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
