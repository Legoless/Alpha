//
//  ALPHATableDataRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableDataRendererViewController.h"

#import "ALPHAConverterManager.h"
#import "ALPHASerializerManager.h"

#import "ALPHAGlobalActionIdentifiers.h"
#import "ALPHAScreenItem.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHABlockActionItem.h"
#import "ALPHASelectorActionItem.h"
#import "ALPHAManager.h"
#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"
#import "ALPHATableScreenModel.h"
#import "ALPHAScreenManager.h"

@interface ALPHATableDataRendererViewController ()

@property (nonatomic, strong) NSTimer *refreshTimer;

@end

@implementation ALPHATableDataRendererViewController

#pragma mark - Getters and Setters

- (void)setScreenModel:(ALPHAScreenModel *)screenModel
{
    _screenModel = screenModel;
    
    if ([screenModel.rightAction.request.identifier isEqualToString:ALPHAActionCloseIdentifier])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.title = screenModel.title;
    
    if (screenModel.expiration > 0 && self.source)
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
    
    if (screenModel.request)
    {
        self.request = screenModel.request;
    }
    
    [self.tableView reloadData];
}

- (ALPHATableScreenModel *)tableScreenModel
{
    return (ALPHATableScreenModel *)self.screenModel;
}

- (void)setObject:(id<ALPHASerializableItem>)object
{
    _object = object;
    
    if ([object isKindOfClass:[ALPHAScreenModel class]])
    {
        self.screenModel = (ALPHAScreenModel *)object;
    }
    else
    {
        //
        // Use a data converter to get screen model
        //
        
        if ([[ALPHAConverterManager sharedManager] canConvertObject:object])
        {
            self.screenModel = [[ALPHAConverterManager sharedManager] screenModelForObject:object];
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
    
    if (!self.object)
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
    
    [self.source dataForRequest:self.request completion:^(ALPHAModel *dataModel, NSError *error) {
        self.object = dataModel;
        
        [self.refreshControl endRefreshing];
        
        //
        // TODO: Handle error and display it properly (this can happen with over network sources)
        //
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableScreenModel.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.tableScreenModel.sections[section] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALPHAScreenItem *item = [self.tableScreenModel.sections[indexPath.section] items][indexPath.row];
    
    NSString *cellIdentifier = [self cellIdentifierForDefaultStyle:item.style];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:item.style reuseIdentifier:cellIdentifier];
        
        ALPHATheme* theme = [ALPHAManager sharedManager].theme;
        
        [self cell:cell applyTheme:theme];
    }
    
    [self cell:cell applyItem:item];
    
    return cell;
}

#pragma mark - Cell Configuration

- (void)cell:(UITableViewCell *)cell applyTheme:(ALPHATheme *)theme
{
    cell.textLabel.font = [theme themeFontWithFont:cell.textLabel.font];
    cell.detailTextLabel.font = [theme themeFontWithFont:cell.detailTextLabel.font];
    
    cell.textLabel.textColor = theme.tintColor;
    cell.detailTextLabel.textColor = [theme.tintColor colorWithAlphaComponent:0.5];
    
    cell.backgroundColor = theme.backgroundColor;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = theme.highlightedBackgroundColor;
    
    cell.detailTextLabel.minimumScaleFactor = 0.5;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.adjustsLetterSpacingToFitWidth = YES;
}

- (void)cell:(UITableViewCell *)cell applyItem:(ALPHAScreenItem *)item
{
    if (item.accessory != UITableViewCellAccessoryNone)
    {
        cell.accessoryType = item.accessory;
    }
    else if ( ([item isKindOfClass:[ALPHAActionItem class]] || [item object]) && ![item isKindOfClass:[ALPHASelectorActionItem class]])
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([item.icon isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = item.icon;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    [self applyStringObject:[self titleForItem:item] toLabel:cell.textLabel];
    [self applyStringObject:[self detailForItem:item] toLabel:cell.detailTextLabel];
}

- (id)titleForItem:(ALPHAScreenItem *)item
{
    if (item.attributedTitleText)
    {
        return item.attributedTitleText;
    }
    
    NSMutableString* text = [NSMutableString string];
    
    if ([item.icon isKindOfClass:[NSString class]])
    {
        [text appendString:item.icon];
        [text appendString:@"  "];
    }
    
    if (item.titleText.length)
    {
        [text appendString:item.titleText];
    }
    else if (item.title)
    {
        [text appendString:[item.title description]];
    }

    return text.copy;
}

- (id)detailForItem:(ALPHAScreenItem *)item
{
    if (item.attributedDetailText)
    {
        return item.attributedDetailText;
    }
    
    NSString* detail = @"";
    
    if ([item.detail isKindOfClass:[NSNumber class]])
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
    else if (item.detailText.length)
    {
        detail = item.detailText;
    }
    else
    {
        detail = [item.detail description];
    }
    
    return detail;
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
    return [self.tableScreenModel.sections[section] title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    // Action mechanic
    //
    
    ALPHAScreenItem *item = [self.tableScreenModel.sections[indexPath.section] items][indexPath.row];
    
    [[ALPHAScreenManager defaultManager] renderer:self didSelectItem:item];
}

#pragma mark - Private Methods

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

- (void)applyStringObject:(id)object toLabel:(UILabel *)label
{
    if ([object isKindOfClass:[NSString class]])
    {
        label.text = object;
    }
    else if ([object isKindOfClass:[NSAttributedString class]])
    {
        label.attributedText = object;
    }
}

@end
