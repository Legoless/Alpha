//
//  ALPHATableDataRendererViewController.h
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataRenderer.h"
#import "ALPHAViewController.h"
#import "ALPHAScreenModel.h"

@interface ALPHATableDataRendererViewController : UITableViewController <ALPHADataRenderer>

@property (nonatomic, weak) id <ALPHAViewControllerDelegate> delegate;

#pragma mark - ALPHADataRenderer

@property (nonatomic, strong) ALPHAScreenModel* screenModel;

@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, strong) id<ALPHADataSource> source;
@property (nonatomic, strong) id<ALPHASerializableItem> object;

@end
