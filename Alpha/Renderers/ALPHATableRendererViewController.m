//
//  ALPHATableRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableRendererViewController.h"

#import "UIImage+Creation.h"

#import "ALPHAConverterManager.h"

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

@interface ALPHATableRendererViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSTimer *refreshTimer;

@end

@implementation ALPHATableRendererViewController

@synthesize theme = _theme;

#pragma mark - Getters and Setters

- (void)setScreenModel:(ALPHAScreenModel *)screenModel
{
    _screenModel = screenModel;
    
    [self updateNavigationItems];
    
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
    
    if ([screenModel isKindOfClass:[ALPHATableScreenModel class]])
    {
        if (self.tableScreenModel.rowHeight > 0.0)
        {
            self.tableView.rowHeight = self.tableScreenModel.rowHeight;
        }
        
        self.tableView.separatorStyle = self.tableScreenModel.separatorStyle;
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

- (ALPHATheme *)theme
{
    if (!_theme)
    {
        _theme = [ALPHAManager defaultManager].theme;
    }
    
    return _theme;
}

- (void)setTheme:(ALPHATheme *)theme
{
    _theme = theme;
    
    self.view.backgroundColor = (self.tableView.style == UITableViewStylePlain) ? theme.cellBackgroundColor : theme.backgroundColor;
    self.tableView.separatorColor = theme.tableSeparatorColor;
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
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateNavigationItems];
    
    if (!self.object || self.screenModel.expiration > 0)
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

- (void)rightBarButtonTap:(UIBarButtonItem *)button
{
    if (self.screenModel.rightAction)
    {
        [[ALPHAScreenManager defaultManager] renderer:self didSelectItem:self.screenModel.rightAction];
    }
}

- (void)donePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}

- (void)refresh
{    
    [self.source dataForRequest:self.request completion:^(ALPHAModel *dataModel, NSError *error)
    {
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
    ALPHAScreenItem *item = (ALPHAScreenItem *)[self.tableScreenModel.sections[indexPath.section] items][indexPath.row];
    
    //
    // Pull cell identifier based on class string
    //
    NSString *cellIdentifier = item.cellClass;
    
    if (cellIdentifier)
    {
        cellIdentifier = [self cellIdentifierForDefaultStyle:item.style];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //
    // Create cell and apply theme
    //
    
    if (!cell)
    {
        Class class = NSClassFromString(item.cellClass);
        
        //
        // Check for table view cell subclass, if not, revert to default
        //
        if (![class isSubclassOfClass:[UITableViewCell class]])
        {
            class = [UITableViewCell class];
        }
        
        if (!cell)
        {
            cell = [[class alloc] initWithStyle:item.style reuseIdentifier:cellIdentifier];
        }
        
        [self cell:cell applyTheme:self.theme item:item];
    }
    
    //
    // Apply item to cell
    //
    
    [self cell:cell applyItem:item];
    
    return cell;
}

#pragma mark - Cell Configuration

- (void)cell:(UITableViewCell *)cell applyTheme:(ALPHATheme *)theme item:(ALPHAScreenItem *)item
{
    cell.textLabel.font = theme.cellTitleFont;
    cell.textLabel.textColor = theme.cellTitleColor;
    
    if (item.style == UITableViewCellStyleSubtitle)
    {
        cell.detailTextLabel.font = theme.cellSubtitleFont;
        cell.detailTextLabel.textColor = theme.cellSubtitleColor;
    }
    else
    {
        cell.detailTextLabel.font = theme.cellDetailFont;
        cell.detailTextLabel.textColor = theme.cellDetailColor;
    }
    cell.backgroundColor = theme.cellBackgroundColor;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = theme.cellSelectedBackgroundColor;
    
    cell.detailTextLabel.minimumScaleFactor = 0.5;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.tintColor = theme.cellTintColor;
    cell.imageView.tintColor = theme.cellTintColor;
    //cell.detailTextLabel.adjustsLetterSpacingToFitWidth = YES;
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
        cell.imageView.contentMode = item.imageContentMode;
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    [self applyStringObject:[self titleForItem:item] toLabel:cell.textLabel];
    [self applyStringObject:[self detailForItem:item] toLabel:cell.detailTextLabel];
    [self applyParameters:item.cellParameters toCell:cell];
    
    if (item.transparent)
    {
        cell.tintColor = [cell.tintColor colorWithAlphaComponent:0.2];
    }
    else
    {
        cell.tintColor = [cell.tintColor colorWithAlphaComponent:1.0];
    }
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

    return text.copy;
}

- (id)detailForItem:(ALPHAScreenItem *)item
{
    if (item.attributedDetailText.length)
    {
        return item.attributedDetailText;
    }
    else if (item.detailText.length)
    {
        return item.detailText;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self tableView:tableView titleForHeaderInSection:section])
    {
        return (tableView.style == UITableViewStylePlain) ? self.theme.tableHeaderHeight : self.theme.tableHeaderGroupedHeight;
    }
    
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self tableView:tableView titleForFooterInSection:section])
    {
        return (tableView.style == UITableViewStylePlain) ? self.theme.tableFooterHeight : self.theme.tableFooterGroupedHeight;
    }
    
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = (tableView.style == UITableViewStylePlain) ? self.theme.tableHeaderBackgroundColor : self.theme.tableHeaderGroupedBackgroundColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = (tableView.style == UITableViewStylePlain) ? self.theme.tableHeaderFontColor : self.theme.tableHeaderGroupedFontColor;
    label.font = (tableView.style == UITableViewStylePlain) ? self.theme.tableHeaderFont : self.theme.tableHeaderGroupedFont;
    
    if (tableView.style == UITableViewStylePlain)
    {
        label.frame = [self.theme rect:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.theme.tableHeaderHeight) withMargin:self.theme.tableHeaderMargin];
    }
    else
    {
        label.frame = [self.theme rect:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.theme.tableHeaderGroupedHeight) withMargin:self.theme.tableHeaderGroupedMargin];
    }
    
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    
    if (tableView.style == UITableViewStyleGrouped)
    {
        label.text = [label.text uppercaseString];
    }
        
    [headerView addSubview:label];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = (tableView.style == UITableViewStylePlain) ? self.theme.tableFooterBackgroundColor : self.theme.tableFooterGroupedBackgroundColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = (tableView.style == UITableViewStylePlain) ? self.theme.tableFooterFontColor : self.theme.tableFooterGroupedFontColor;
    label.font = (tableView.style == UITableViewStylePlain) ? self.theme.tableFooterFont : self.theme.tableFooterGroupedFont;
    
    if (tableView.style == UITableViewStylePlain)
    {
        label.frame = [self.theme rect:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.theme.tableFooterHeight) withMargin:self.theme.tableFooterMargin];
    }
    else
    {
        label.frame = [self.theme rect:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.theme.tableFooterGroupedHeight) withMargin:self.theme.tableFooterGroupedMargin];
    }
    
    label.text = [self tableView:tableView titleForFooterInSection:section];
    
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
    
    ALPHAScreenItem *item = (ALPHAScreenItem *)[self.tableScreenModel.sections[indexPath.section] items][indexPath.row];
    
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

- (void)updateNavigationItems
{
    if ([self.screenModel.rightAction.request.identifier isEqualToString:ALPHAActionCloseIdentifier])
    {
        [self createCloseBarButtonItem];
    }
    else if (self.navigationController.viewControllers.firstObject == self)
    {
        [self createCloseBarButtonItem];
    }
    else if (self.screenModel.rightAction)
    {
        [self createRightBarButtonItem];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }

}

- (void)createRightBarButtonItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.screenModel.rightAction.title style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonTap:)];
}

- (void)createCloseBarButtonItem
{
    if (![self.navigationItem.rightBarButtonItem.title isEqualToString:@"Close"])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    }
}

- (UIRefreshControl *)createRefreshControl
{
    //
    // Refresh control
    //
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [self.theme.mainColor colorWithAlphaComponent:0.5];
    
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
        
        //scopeView.tintColor = [UIColor redColor];
        //scopeView.backgroundColor = self.theme.highlightedBackgroundColor;
        scopeView.backgroundColor = self.theme.searchBackgroundColor;
        
        scopeView.placeholder = screenModel.searchBarPlaceholder;
        
        scopeView.showsSearchBar = (screenModel.searchBarPlaceholder != nil) ? YES : NO;
        
        scopeView.scopeButtonTitles = screenModel.scopes;

        scopeView.showsScopeBar = (screenModel.scopes != nil) ? YES : NO;
        scopeView.searchBar.keyboardAppearance = self.theme.keyboardAppearance;

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
    if ([object isKindOfClass:[NSAttributedString class]])
    {
        label.attributedText = object;
    }
    else
    {
        label.text = object;
    }
}

- (void)applyParameters:(NSDictionary *)parameters toCell:(UITableViewCell *)cell
{
    for (id key in parameters)
    {
        [cell setValue:parameters[key] forKey:key];
    }
}

@end
