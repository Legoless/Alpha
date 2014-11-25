//
//  FLEXInfoTableViewController.m
//  UICatalog
//
//  Created by Dal Rupnik on 07/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXGlobalsTableViewController.h"
#import "FLEXInfoTableViewController.h"
#import "FLEXUtility.h"
#import "FLEXLibrariesTableViewController.h"
#import "FLEXClassesTableViewController.h"
#import "FLEXObjectExplorerViewController.h"
#import "FLEXObjectExplorerFactory.h"
#import "FLEXLiveObjectsTableViewController.h"
#import "FLEXFileBrowserTableViewController.h"
#import "FLEXGlobalsTableViewControllerEntry.h"
#import "FLEXManager+Private.h"
#import "FLEXNetworkTableViewController.h"
#import "FLEXEnvironmentTableViewController.h"
#import "FLEXStatusTableViewController.h"
#import "FLEXConsoleTableViewController.h"
#import "FLEXScreenshotTableViewController.h"
#import "FLEXNotificationTableViewController.h"
#import "FLEXPluginManager.h"
#import "FLEXMenuItem.h"

@interface FLEXInfoTableViewController ()

@property (nonatomic, strong) NSMutableArray *entries;

@end

@implementation FLEXInfoTableViewController

- (NSMutableArray *)entries
{
    if (!_entries)
    {
        _entries = [NSMutableArray array];
    }
    
    return _entries;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.title = @"Diagnostics";
        
        [self buildEntries];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];
}

#pragma mark -

- (void)donePressed:(id)sender
{
    [self.delegate viewControllerDidFinish:self];
}

#pragma mark - Internal

- (void)buildEntries
{
    //
    // Build entries for FLEX.
    //
    
    [self.entries removeAllObjects];
    
    NSArray* plugins = [FLEXPluginManager sharedManager].plugins;
    
    for (FLEXPlugin* plugin in plugins)
    {
        if (!plugin.isEnabled)
        {
            continue;
        }
        
        for (FLEXActionItem* action in plugin.actions)
        {
            if ([action isKindOfClass:[FLEXMenuItem class]] && action.isEnabled)
            {
                FLEXMenuItem* menuAction = (FLEXMenuItem *)action;
                
                [self.entries addObject:menuAction];
            }
        }
    }
    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    
    self.entries = [[self.entries sortedArrayUsingDescriptors:@[ sortDescriptor ]] mutableCopy];
}

#pragma mark - Table Data Helpers

- (FLEXGlobalsTableViewControllerEntry *)globalEntryAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXMenuItem* menuAction = self.entries[indexPath.row];
    
    FLEXGlobalsTableViewControllerEntryNameFuture titleFuture = ^NSString *
    {
        return menuAction.title;
    };
    FLEXGlobalsTableViewControllerViewControllerFuture viewControllerFuture = ^UIViewController *
    {
        Class viewControllerClass = NSClassFromString(menuAction.viewControllerClass);
        
        return [[viewControllerClass alloc] init];
    };
    
    return [FLEXGlobalsTableViewControllerEntry entryWithNameFuture:titleFuture viewControllerFuture:viewControllerFuture];
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXMenuItem* menuAction = self.entries[indexPath.row];
    
    if ([menuAction.icon isKindOfClass:[NSString class]])
    {
        return [NSString stringWithFormat:@"%@  %@", menuAction.icon, menuAction.title];
    }

    return menuAction.title;
}

- (UIViewController *)viewControllerToPushForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXGlobalsTableViewControllerEntry *entry = [self globalEntryAtIndexPath:indexPath];
    
    return entry.viewControllerFuture();
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [FLEXUtility defaultTableViewCellLabelFont];
    }
    
    FLEXMenuItem* menuAction = self.entries[indexPath.row];
    
    cell.textLabel.text = [self titleForRowAtIndexPath:indexPath];
    
    if ([menuAction.icon isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = menuAction.icon;
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewControllerToPush = [self viewControllerToPushForRowAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
