//
//  ALPHAHierarchyTableViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 16/6/2015.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAHierarchyTableViewController.h"
#import "ALPHARuntimeUtility.h"
#import "ALPHAHierarchyTableViewCell.h"
#import "ALPHAScreenManager.h"
#import "ALPHATableScreenModel.h"
#import "ALPHAActions.h"

#import "UIColor+Utility.h"

static const NSInteger kALPHAHierarchyScopeViewsAtTapIndex = 0;
static const NSInteger kALPHAHierarchyScopeFullHierarchyIndex = 1;

@interface ALPHAHierarchyTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *allViews;
@property (nonatomic, strong) NSDictionary *depthsForViews;
@property (nonatomic, strong) NSArray *viewsAtTap;
@property (nonatomic, strong) NSArray *displayedViews;

@end

@implementation ALPHAHierarchyTableViewController

#pragma mark - Getters and Setters

- (ALPHATableScreenModel *)updatedModel
{
    NSMutableArray* items = [NSMutableArray array];
    
    for (UIView *view in self.displayedViews)
    {
        ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
        item.style = UITableViewCellStyleSubtitle;
        
        item.title = [ALPHARuntimeUtility descriptionForView:view includingFrame:NO];
        item.detail = [ALPHARuntimeUtility detailDescriptionForView:view];
        
        NSNumber *depth = [self.depthsForViews objectForKey:[NSValue valueWithNonretainedObject:view]];
        
        item.cellClass = @"ALPHAHierarchyTableViewCell";
        item.cellParameters = @{ @"viewDepth" : depth, @"viewColor" : [UIColor alpha_consistentRandomColorForObject:view] };
        item.accessory = UITableViewCellAccessoryDetailDisclosureButton;
        
        item.transparent = view.hidden;
        
        item.object = view;
        
        [items addObject:item];
    }
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    section.items = items.copy;
    
    ALPHATableScreenModel *model = [[ALPHATableScreenModel alloc] init];
    model.title = @"View Hierarchy";
    model.separatorStyle = UITableViewCellSeparatorStyleNone;
    model.rowHeight = 50.0;
    
    model.rightAction = [[ALPHAActionItem alloc] initWithIdentifier:ALPHAActionCloseIdentifier];
    
    model.searchBarPlaceholder = @"Filter";
    
    if ([self showScopeBar])
    {
        model.scopes = @[ @"Views at Tap", @"Full Hierarchy" ];
    }
    
    model.sections = @[ section ];
    
    return model;
}

#pragma mark - Initialization

- (id)initWithViews:(NSArray *)allViews viewsAtTap:(NSArray *)viewsAtTap selectedView:(UIView *)selectedView depths:(NSDictionary *)depthsForViews
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self)
    {
        self.allViews = allViews;
        self.depthsForViews = depthsForViews;
        self.viewsAtTap = viewsAtTap;
        self.selectedView = selectedView;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Separator inset clashes with persistent cell selection.
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self updateDisplayedViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self trySelectCellForSelectedViewWithScrollPosition:UITableViewScrollPositionMiddle];
}

- (void)refresh
{
    //
    // Override refresh to disable any functionality
    //
}

#pragma mark Selection and Filtering Helpers

- (void)trySelectCellForSelectedViewWithScrollPosition:(UITableViewScrollPosition)scrollPosition
{
    NSUInteger selectedViewIndex = [self.displayedViews indexOfObject:self.selectedView];
    
    if (selectedViewIndex != NSNotFound)
    {
        NSIndexPath *selectedViewIndexPath = [NSIndexPath indexPathForRow:selectedViewIndex inSection:0];
        [self.tableView selectRowAtIndexPath:selectedViewIndexPath animated:YES scrollPosition:scrollPosition];
    }
}

- (void)updateDisplayedViews
{
    NSArray *candidateViews = nil;
    
    if ([self showScopeBar])
    {
        if (self.detailView.selectedScopeButtonIndex == kALPHAHierarchyScopeViewsAtTapIndex)
        {
            candidateViews = self.viewsAtTap;
        }
        else if (self.detailView.selectedScopeButtonIndex == kALPHAHierarchyScopeFullHierarchyIndex)
        {
            candidateViews = self.allViews;
        }
    }
    else
    {
        candidateViews = self.allViews;
    }
    
    if ([self.detailView.searchBar.text length] > 0)
    {
        self.displayedViews = [candidateViews filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *candidateView, NSDictionary *bindings)
        {
            NSString *title = [ALPHARuntimeUtility descriptionForView:candidateView includingFrame:NO];
            return [title rangeOfString:self.detailView.searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound;
        }]];
    }
    else
    {
        self.displayedViews = candidateViews;
    }
    
    self.screenModel = [self updatedModel];
}

- (BOOL)showScopeBar
{
    return [self.viewsAtTap count] > 0;
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateDisplayedViews];
    
    // If the search bar text field is active, don't scroll on selection because we may want to continue typing.
    // Otherwise, scroll so that the selected cell is visible.
    UITableViewScrollPosition scrollPosition = self.detailView.searchBar.isFirstResponder ? UITableViewScrollPositionNone : UITableViewScrollPositionMiddle;
    [self trySelectCellForSelectedViewWithScrollPosition:scrollPosition];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self updateDisplayedViews];
    [self trySelectCellForSelectedViewWithScrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Table View Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedView = [self.displayedViews objectAtIndex:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIView *drillInView = [self.displayedViews objectAtIndex:indexPath.row];

    [[ALPHAScreenManager defaultManager] pushObject:[ALPHARequest requestForObject:drillInView]];
}


#pragma mark - Button Actions

- (void)donePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}

@end
