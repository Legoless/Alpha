//
//  ALPHAPermissionSource.m
//  Alpha
//
//  Created by Dal Rupnik on 02/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAUtility.h"

#import "ALPHAPermissionSource.h"

#import "ALPHAPermissions.h"

#import "ALPHAModel.h"
#import "ALPHATableScreenModel.h"

NSString* const ALPHAPermissionDataIdentifier = @"com.unifiedsense.alpha.data.permission";

#pragma mark - Permission Source

@interface ALPHAPermissionSource ()

@end

@implementation ALPHAPermissionSource

#pragma mark - Getters and Setters

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAPermissionDataIdentifier];
    }
    
    return self;
}

#pragma mark - ALPHADataSource

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    //
    // Data model
    //
    
    ALPHATableScreenModel* dataModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAPermissionDataIdentifier];
    dataModel.title = @"Permissions";
    dataModel.tableViewStyle = UITableViewStyleGrouped;
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:[self permissionSection]];
    
    //[array addObject:[self notificationSection]];
    
    ALPHAScreenSection* healthSection = [self healthSection];
    
    if (healthSection)
    {
        [array addObject:healthSection];
    }
    
    ALPHAScreenSection* socialSection = [self socialSection];
    
    if (socialSection)
    {
        [array addObject:socialSection];
    }
    
    dataModel.sections = array.copy;
    
    return dataModel;
}

#pragma mark - Private Methods

- (ALPHAScreenSection *)permissionSection
{
    //
    // TODO: Add Notifications, HomeKit, Mobile Data and Motion Activity Permissions,
    // Ask for permission execution.
    //
    
    ALPHAScreenSection* permissionSection = [[ALPHAScreenSection alloc] initWithIdentifier:@"com.unifiedsense.alpha.data.permission.global"];
    permissionSection.headerText = @"Global";
    
    permissionSection.items = [self itemsForPermissions:@[
        [ALPHABluetoothPermission new],
        [ALPHAEventPermission new],
        [ALPHAVideoPermission new],
        [ALPHAContactPermission new],
        [ALPHALocationPermission new],
        [ALPHAAudioPermission new],
        [ALPHAAssetPermission new],
        [ALPHAEventPermission reminderPermission]
    ]];

    return permissionSection;
}

- (ALPHAScreenSection *)healthSection
{
    NSArray *permissions = [ALPHAHealthPermission allPermissions];
    
    if (!permissions)
    {
        return nil;
    }
    
    ALPHAScreenSection *healthSection = [[ALPHAScreenSection alloc] initWithIdentifier:@"com.unifiedsense.alpha.data.permission.health"];
    healthSection.headerText = @"HealthKit";
    
    healthSection.items = [self itemsForPermissions:permissions];
    
    return healthSection;
}

- (ALPHAScreenSection *)socialSection
{
    ALPHAScreenSection* socialSection = [[ALPHAScreenSection alloc] initWithIdentifier:@"com.unifiedsense.alpha.data.permission.social"];
    socialSection.headerText = @"Social Accounts";
    
    socialSection.items = [self itemsForPermissions:[ALPHASocialPermission allPermissions]];
    
    return socialSection;
}

- (NSArray *)itemsForPermissions:(NSArray *)permissions
{
    NSMutableArray *items = [NSMutableArray array];
    
    for (ALPHAPermission *permission in permissions)
    {
        ALPHAScreenItem *item = [[ALPHAScreenItem alloc] init];
        item.title = [permission name];
        item.detail = [permission statusString];
        item.style = UITableViewCellStyleValue1;
        
        [items addObject:item];
    }
    
    return items;
}

@end
