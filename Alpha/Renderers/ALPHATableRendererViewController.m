//
//  ALPHATableRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableRendererViewController.h"

#import "UIImage+ALPHACreation.h"

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

#import "ALPHASearchScopeView.h"

@interface ALPHATableRendererViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSTimer *refreshTimer;

@property (nonatomic, strong) ALPHASearchScopeView *detailView;

@end

@implementation ALPHATableRendererViewController

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
    
    //
    // Refresh timer
    //
    
    [self createRefreshTimerWithModel:screenModel];
    
    //
    // Search support
    //
    
    [self createSearchBarWithModel:screenModel];
    
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

- (void)setTheme:(ALPHATheme *)theme
{
    _theme = theme;
    
    self.view.backgroundColor = theme.backgroundColor;
    self.tableView.separatorColor = theme.highlightedBackgroundColor;
}

#pragma mark - Initialization

- (instancetype)initWithObject:(id)object
{
    if ([object isKindOfClass:[ALPHATableScreenModel class]])
    {
        return [self initWithStyle:[(ALPHATableScreenModel *)object tableViewStyle]];
    }
    
    return [self init];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        
        [self cell:cell applyTheme:self.theme];
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
    label.font = [self.theme themeFontOfSize:12.0];
    label.textColor = [self.theme.tintColor colorWithAlphaComponent:0.6];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [self.theme.highlightedBackgroundColor colorWithAlphaComponent:0.8];
    [headerView addSubview:label];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(17.0, 8.0, self.view.bounds.size.width - 17.0, 12.0);
    label.font = [self.theme themeFontOfSize:12.0];
    label.textColor = [self.theme.tintColor colorWithAlphaComponent:0.6];
    label.text = [self tableView:tableView titleForFooterInSection:section];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [self.theme.highlightedBackgroundColor colorWithAlphaComponent:0.8];
    [footerView addSubview:label];
    
    return footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableScreenModel.sections[section] headerText];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.tableScreenModel.sections[section] footerText];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    // Action mechanic
    //
    
    ALPHAScreenItem *item = [self.tableScreenModel.sections[indexPath.section] items][indexPath.row];
    
    if ([item isKindOfClass:[ALPHAActionItem class]] || [item object])
    {
        [[ALPHAScreenManager defaultManager] renderer:self didSelectItem:item];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self updateTableDataForSearchFilter];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateTableDataForSearchFilter];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Dismiss the keyboard when interacting with filtered results.
    [self.detailView.searchBar endEditing:YES];
}

- (void)updateTableDataForSearchFilter
{
    self.request = [self.request searchRequestWithText:self.detailView.searchBar.text scope:@(self.detailView.segmentedControl.selectedSegmentIndex)];
    
    [self refresh];
}

#pragma mark - Private Methods

- (UIRefreshControl *)createRefreshControl
{
    //
    // Refresh control
    //
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [self.theme.tintColor colorWithAlphaComponent:0.5];
    
    return refreshControl;
}

- (void)createRefreshTimerWithModel:(ALPHAScreenModel *)screenModel
{
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
}

- (void)createSearchBarWithModel:(ALPHAScreenModel *)screenModel
{
    if ( (screenModel.searchBarPlaceholder || screenModel.scopes.count) && !self.detailView)
    {
        ALPHASearchScopeView *scopeView = [[ALPHASearchScopeView alloc] init];
        scopeView.delegate = self;
        
        scopeView.tintColor = self.theme.tintColor;
        //scopeView.backgroundColor = self.theme.highlightedBackgroundColor;
        scopeView.backgroundColor = [UIColor colorWithWhite:0.08 alpha:1.0];
        
        scopeView.placeholder = screenModel.searchBarPlaceholder;
        
        scopeView.showsSearchBar = (screenModel.searchBarPlaceholder != nil) ? YES : NO;
        
        scopeView.scopeButtonTitles = screenModel.scopes;

        scopeView.showsScopeBar = (screenModel.scopes != nil) ? YES : NO;

        [scopeView sizeToFit];
        
        self.detailView = scopeView;
        
        self.tableView.tableHeaderView = self.detailView;
    }
    else if (!(screenModel.searchBarPlaceholder || screenModel.scopes.count) && self.detailView)
    {
        [self.detailView removeFromSuperview];
        self.tableView.tableHeaderView = nil;
        
        self.detailView = nil;
    }
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
