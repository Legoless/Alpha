//
//  FLEXInfoTableViewController.h
//  UICatalog
//
//  Created by Dal Rupnik on 07/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@protocol FLEXViewControllerDelegate <NSObject>

- (void)viewControllerDidFinish:(UIViewController *)viewController;

@end

@interface FLEXInfoTableViewController : UITableViewController

@property (nonatomic, weak) id <FLEXViewControllerDelegate> delegate;

@end

