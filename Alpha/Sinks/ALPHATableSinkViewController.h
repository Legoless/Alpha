//
//  ALPHATableDataViewController.h
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSink.h"
#import "ALPHAViewController.h"

@interface ALPHATableSinkViewController : UITableViewController <ALPHADataSink>

@property (nonatomic, weak) id <FLEXViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *rootIdentifier;
@property (nonatomic, strong) id<ALPHADataSource> source;
@property (nonatomic, strong) id<ALPHASerializableItem> data;

@end
