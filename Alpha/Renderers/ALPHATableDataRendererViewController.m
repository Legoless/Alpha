//
//  ALPHATableDataRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableDataRendererViewController.h"

#import "ALPHAConverterManager.h"

#import "ALPHAGlobalActions.h"
#import "ALPHAScreenItem.h"
#import "ALPHAMenuActionItem.h"
#import "ALPHABlockActionItem.h"
#import "ALPHAManager.h"
#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"

#import "FLEXObjectExplorerFactory.h"

@interface ALPHATableDataRendererViewController ()

@property (nonatomic, strong) NSTimer *refreshTimer;
@property (nonatomic, strong) ALPHAScreenModel* screenModel;

@end

@implementation ALPHATableDataRendererViewController

#pragma mark - Getters and Setters

- (void)setScreenModel:(ALPHAScreenModel *)screenModel
{
    _screenModel = screenModel;
    
    if ([screenModel.rightAction.identifier isEqualToString:ALPHAActionCloseIdentifier])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.title = screenModel.title;
    
    if (screenModel.expiration > 0)
    {
        if (!self.refreshControl)
        {
            self.refreshControl = [self createRefreshControl];
        }
        
        self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:self.screenModel.expiration target:self selector:@selector(refresh) userInfo:nil repeats:NO];
    }
    else
    {
        if (self.refreshControl)
        {
            [self.refreshControl endRefreshing];
            self.refreshControl = nil;
        }
        
        [self.refreshTimer invalidate];
        self.refreshTimer = nil;
    }
    
    [self.tableView reloadData];
}

- (void)setData:(id<ALPHASerializableItem>)data
{
    _data = data;
    
    if ([data isKindOfClass:[ALPHAScreenModel class]])
    {
        self.screenModel = data;
    }
    else
    {
        //
        // Use a data converter to get screen model
        //
        
        if ([[ALPHAConverterManager sharedManager] canConvertModel:data])
        {
            self.screenModel = [[ALPHAConverterManager sharedManager] screenModelForModel:data];
        }
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [ALPHAManager sharedManager].theme.backgroundColor;
    self.tableView.separatorColor = [ALPHAManager sharedManager].theme.highlightedBackgroundColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.data)
    {
        [self refresh];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //self.data = nil;
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}

#pragma mark - Actions

- (void)donePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}

- (void)refresh
{
    [self.refreshControl beginRefreshing];
    
    [self.source refreshWithIdentifier:self.dataIdentifier completion:^(ALPHAModel *dataModel, NSError *error) {
        self.data = dataModel;
        
        [self.refreshControl endRefreshing];
        
        //
        // TODO: Handle error and display it properly (this can happen with over network sources)
        //
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.screenModel.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.screenModel.sections[section] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALPHAScreenItem *item = [self.screenModel.sections[indexPath.section] items][indexPath.row];
    
    NSString *cellIdentifier = [self cellIdentifierForDefaultStyle:item.style];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:item.style reuseIdentifier:cellIdentifier];
        
        ALPHATheme* theme = [ALPHAManager sharedManager].theme;
        
        cell.textLabel.font = [theme themeFontWithFont:cell.textLabel.font];
        cell.detailTextLabel.font = [theme themeFontWithFont:cell.detailTextLabel.font];
        
        cell.textLabel.textColor = theme.tintColor;
        cell.detailTextLabel.textColor = [theme.tintColor colorWithAlphaComponent:0.5];
        
        cell.backgroundColor = theme.backgroundColor;
        cell.selectedBackgroundView = [UIView new];
        cell.selectedBackgroundView.backgroundColor = theme.highlightedBackgroundColor;
    }
        
    cell.detailTextLabel.minimumScaleFactor = 0.5;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.adjustsLetterSpacingToFitWidth = YES;
    
    if ([item isKindOfClass:[ALPHAActionItem class]] || [item model])
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSMutableString* text = [NSMutableString string];
    
    if ([item.icon isKindOfClass:[NSString class]])
    {
        [text appendString:item.icon];
        [text appendString:@"  "];
    }
    else if ([item.icon isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = item.icon;
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    if (item.title.length)
    {
        [text appendString:item.title];
    }
    
    cell.textLabel.text = text;
    
    NSString* detail = @"";
    
    if ([item.detail isKindOfClass:[NSString class]])
    {
        detail = item.detail;
    }
    else if ([item.detail isKindOfClass:[NSNumber class]])
    {
        //
        // Check for boolean here
        //
        
        NSNumber* detailNumber = item.detail;
        
        if (strcmp([detailNumber objCType], @encode(BOOL)) == 0)
        {
            BOOL detailData = detailNumber.boolValue;
            
            detail = detailData ? @"YES" : @"NO";
        }
        else
        {
            detail = [NSString stringWithFormat:@"%lld", detailNumber.longLongValue];
        }
    }
    else
    {
        detail = [item.detail description];
    }
    
    cell.detailTextLabel.text = detail;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(17.0, 8.0, self.view.bounds.size.width - 17.0, 12.0);
    label.font = [[ALPHAManager sharedManager].theme themeFontOfSize:12.0];
    label.textColor = [[ALPHAManager sharedManager].theme.tintColor colorWithAlphaComponent:0.6];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [[ALPHAManager sharedManager].theme.highlightedBackgroundColor colorWithAlphaComponent:0.8];
    [headerView addSubview:label];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.screenModel.sections[section] title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    // Action mechanic
    //
    
    id item = [self.screenModel.sections[indexPath.section] items][indexPath.row];
    
    if ([item isKindOfClass:[ALPHAMenuActionItem class]])
    {
        ALPHAMenuActionItem* menuItem = item;
        
        UIViewController* controller = menuItem.viewControllerInstance;
        
        if (controller)
        {
            if ([controller conformsToProtocol:@protocol(ALPHADataRenderer)])
            {
                UIViewController<ALPHADataRenderer>* renderer = (UIViewController<ALPHADataRenderer>*)controller;
                
                // Send data source
                renderer.source = self.source;
            }
            
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    else if ([item isKindOfClass:[ALPHABlockActionItem class]])
    {
        ALPHABlockActionItem* blockItem = item;
        
        if (blockItem.actionBlock)
        {
            blockItem.actionBlock([tableView cellForRowAtIndexPath:indexPath]);
        }
    }
    else if ([item model])
    {
        //
        // For data models that send data directly, we will display object view controller explorer
        //
    
        
        UIViewController* controller = [FLEXObjectExplorerFactory explorerViewControllerForObject:[item model]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Helper methods

- (UIRefreshControl *)createRefreshControl
{
    //
    // Refresh control
    //
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [[ALPHAManager sharedManager].theme.tintColor colorWithAlphaComponent:0.5];
    
    return refreshControl;
}

- (NSString *)cellIdentifierForDefaultStyle:(UITableViewCellStyle)style
{
    switch (style)
    {
        case UITableViewCellStyleDefault:
            return @"DefaultCell";
        case UITableViewCellStyleSubtitle:
            return @"SubtitleCell";
        case UITableViewCellStyleValue1:
            return @"Value1Cell";
        case UITableViewCellStyleValue2:
            return @"Value2Cell";
    }
}

@end
