//
//  AAPLCatalogTableTableViewController.m
//  UICatalog
//
//  Created by Ryan Olson on 7/17/14.

#import "AAPLCatalogTableTableViewController.h"

#if DEBUG
// FLEX should only be compiled and used in debug builds.
#import "FLEXManager.h"
#endif

@interface AAPLCatalogTableTableViewController ()

@end

@implementation AAPLCatalogTableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil]];
    
#if DEBUG
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
#endif
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Finish";
    localNotification.alertBody = @"Finish stuff.";
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:86400.0 * 4.0];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)flexButtonTapped:(id)sender
{
#if DEBUG
    // This call shows the FLEX toolbar if it's not already shown.
    [[FLEXManager sharedManager] showExplorer];
#endif
}

@end
