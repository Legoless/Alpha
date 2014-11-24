//
//  FLEXExplorerViewController.h
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXViewController.h"

@interface FLEXExplorerViewController : FLEXViewController <FLEXViewControllerResponder>

@property (nonatomic, weak) id <FLEXViewControllerDelegate> delegate;

- (void)displayInfoTable;

@end