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
#import "FLEXWindow.h"

@interface FLEXScreenshotTableViewController ()

@property (nonatomic, copy) NSArray *screenshots;

@property (nonatomic, strong) NSDateFormatter* fileDateFormatter;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@end

@implementation FLEXScreenshotTableViewController

- (NSDateFormatter *)fileDateFormatter
{
    if (!_fileDateFormatter)
    {
        _fileDateFormatter = [[NSDateFormatter alloc] init];
        _fileDateFormatter.dateFormat = @"yyyy.MM.dd_HH.mm.ss";
    }
    
    return _fileDateFormatter;
}

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
    
    [self loadScreenshots];
}

- (void)loadScreenshots
{
    NSError* error;
    
    NSString *directory = [NSString stringWithFormat:@"%@FLEX/Screenshots", [self documentsDirectory].absoluteString];
    self.screenshots = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL URLWithString:directory] includingPropertiesForKeys:@[] options:0 error:&error];
    
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)addPressed:(id)sender
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    NSMutableArray *excludedWindows = [NSMutableArray array];
    
    for (UIWindow *window in windows)
    {
        if ([window isKindOfClass:[FLEXWindow class]])
        {
            [excludedWindows addObject:window];
        }
    }
    
    UIImage *screenshot = [[UIApplication sharedApplication] screenshotExcludingWindows:excludedWindows ];

    [self saveImage:screenshot];
    
    [self loadScreenshots];
}

- (void)saveImage:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *directory = [NSString stringWithFormat:@"%@FLEX/Screenshots", [self documentsDirectory].absoluteString];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", directory, [self stringForFile]];
    
    NSURL *fileURL = [NSURL URLWithString:filePath];
    
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:&isDir];
    
    if (!exists || !isDir)
    {
        NSError *error;
        
        [[NSFileManager defaultManager] createDirectoryAtURL:[NSURL URLWithString:directory] withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSError* error;
        [imageData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
    }
}

- (NSString *)stringForFile
{
    return [NSString stringWithFormat:@"FLEX_SS_%@.png", [self.fileDateFormatter stringFromDate:[NSDate date]]];
}

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
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
    
    NSDate *date = [self.fileDateFormatter dateFromString:filename];
    
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
