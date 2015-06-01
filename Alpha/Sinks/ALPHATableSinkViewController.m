//
//  ALPHATableSinkViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableSinkViewController.h"

#import "ALPHAGlobalActions.h"
#import "ALPHADataItem.h"
#import "ALPHAMenuActionItem.h"
#import "ALPHABlockActionItem.h"
#import "ALPHAManager.h"

@implementation ALPHATableSinkViewController

#pragma mark - Getters and Setters

- (ALPHADataModel *)dataModel
{
    if ([self.data isKindOfClass:[ALPHADataModel class]])
    {
        return (ALPHADataModel *)self.data;
    }
    
    return nil;
}

- (void)setData:(id<ALPHASerializableItem>)data
{
    _data = data;
    
    if ([data isKindOfClass:[ALPHADataModel class]])
    {
        if (self.navigationItem.rightBarButtonItem)
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        if ([self.dataModel.rightAction.identifier isEqualToString:ALPHAActionCloseIdentifier])
        {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];

        }
        
        self.title = self.dataModel.title;
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
        [self.source refreshWithIdentifier:self.rootIdentifier completion:^(ALPHADataModel *dataModel, NSError *error) {
            self.data = dataModel;
            
            //
            // TODO: Handle error and display it properly (this can happen with over network sources)
            //
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.data = nil;
}

#pragma mark - Actions

- (void)donePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}


#pragma mark - Public

/*
 - (void)refresh
 {
 NSMutableIndexSet* refreshSections = [NSMutableIndexSet indexSet];
 
 NSUInteger index = 0;
 
 for (ALPHADataSection* section in self.dataModel.sections)
 {
 BOOL refresh = [section refresh];
 
 if (refresh)
 {
 [refreshSections addIndex:index];
 }
 
 index++;
 }
 
 if (refreshSections.count)
 {
 [self.tableView reloadSections:refreshSections withRowAnimation:UITableViewRowAnimationAutomatic];
 }
 }*/

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataModel.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataModel.sections[section] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALPHADataItem *item = [self.dataModel.sections[indexPath.section] items][indexPath.row];
    
    NSString *cellIdentifier = [self cellIdentifierForStyle:item.style];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:item.style reuseIdentifier:cellIdentifier];
        
        ALPHATheme* theme = [ALPHAManager sharedManager].theme;
        
        cell.textLabel.font = [theme themeFontWithFont:cell.textLabel.font];
        cell.detailTextLabel.font = [theme themeFontWithFont:cell.detailTextLabel.font];
        
        cell.textLabel.textColor = theme.tintColor;
        cell.detailTextLabel.textColor = theme.tintColor;
        
        cell.backgroundColor = theme.backgroundColor;
        cell.selectedBackgroundView = [UIView new];
        cell.selectedBackgroundView.backgroundColor = theme.highlightedBackgroundColor;
    }
        
    cell.detailTextLabel.minimumScaleFactor = 0.5;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.adjustsLetterSpacingToFitWidth = YES;
    
    if ([item isKindOfClass:[ALPHAActionItem class]])
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
    
    [text appendString:item.title];
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text = item.detail;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.dataModel.sections[section] title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    // Action mechanic
    //
    
    id item = [self.dataModel.sections[indexPath.section] items][indexPath.row];
    
    if ([item isKindOfClass:[ALPHAMenuActionItem class]])
    {
        ALPHAMenuActionItem* menuItem = item;
        
        if (menuItem.viewControllerClass)
        {
            UIViewController* controller = menuItem.viewControllerInstance;
            
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
}

#pragma mark - Helper methods

- (NSString *)cellIdentifierForStyle:(UITableViewCellStyle)style
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
