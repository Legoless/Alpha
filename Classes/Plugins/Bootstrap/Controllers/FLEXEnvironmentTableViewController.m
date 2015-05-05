//
//  FLEXEnvironmentTableViewController.m
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXUtility.h"

#import "FLEXEnvironmentTableViewController.h"

@interface FLEXEnvironmentTableViewController ()

@property (nonatomic, copy) NSArray *environments;
@property (nonatomic, copy) NSString *currentEnvironment;

@end

@implementation FLEXEnvironmentTableViewController

- (Class)bootstrap
{
    return NSClassFromString(@"KZBootstrap");
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.title = @"Environments";
        
        Class bootstrap = [self bootstrap];
        
        if (bootstrap)
        {
            SEL environments = NSSelectorFromString(@"environments");
            SEL currentEnvironment = NSSelectorFromString(@"currentEnvironment");
            
            // TODO: Fix warnings
            self.environments = [bootstrap performSelector:environments];
            self.currentEnvironment = [bootstrap performSelector:currentEnvironment];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.environments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [FLEXUtility defaultTableViewCellLabelFont];
    }
    
    NSString *environment = self.environments[indexPath.row];
    
    cell.textLabel.text = environment;
    
    if ([environment isEqualToString:self.currentEnvironment])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *environment = self.environments[indexPath.row];
    
    if (![environment isEqualToString:self.currentEnvironment])
    {
        NSMutableArray *rows = [NSMutableArray array];
        
        [rows addObject:[NSIndexPath indexPathForRow:[self.environments indexOfObject:environment] inSection:0]];
        [rows addObject:[NSIndexPath indexPathForRow:[self.environments indexOfObject:self.currentEnvironment] inSection:0]];
        
        SEL setCurrentEnvironment = NSSelectorFromString(@"setCurrentEnvironment:");
        
        [[self bootstrap] performSelector:setCurrentEnvironment withObject:environment];
        self.currentEnvironment = environment;
        
        [self.tableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
