//
//  AAPLCatalogTableTableViewController.m
//  UICatalog
//
//  Created by Ryan Olson on 7/17/14.

#import "AAPLCatalogTableTableViewController.h"

#if DEBUG
// FLEX should only be compiled and used in debug builds.
#import "ALPHAManager.h"
#endif

@interface AAPLCatalogTableTableViewController ()

@end

@implementation AAPLCatalogTableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil]];
    
#if DEBUG
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Alpha" style:UIBarButtonItemStylePlain target:self action:@selector(alphaButtonTapped:)];
#endif
    
    //
    // Local notification test
    //
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Finish";
    localNotification.alertBody = @"Finish stuff.";
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:86400.0 * 4.0];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)alphaButtonTapped:(id)sender
{
#if DEBUG
    // This acts as a manual Alpha trigger
    [ALPHAManager sharedManager].interfaceHidden = NO;
#endif
}

@end
