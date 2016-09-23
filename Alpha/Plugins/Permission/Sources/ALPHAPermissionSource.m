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

#import "ALPHAActions.h"

NSString* const ALPHAPermissionDataIdentifier = @"com.unifiedsense.alpha.data.permission";
NSString* const ALPHAActionPermissionRequestIdentifier = @"com.unifiedsense.alpha.action.permission.request";

NSString* const ALPHAActionPermissionRequestPermissionIdentifier = @"com.unifiedsense.alpha.action.permission.request.identifier";

NSString* const ALPHAActionPermissionResetIdentifier = @"com.unifiedsense.alpha.action.permission.reset";

#pragma mark - Permission Source

@interface ALPHAPermissionSource ()

@property (nonatomic, copy) NSArray *permissions;

@end

@implementation ALPHAPermissionSource

#pragma mark - Getters and Setters

- (NSArray *)permissions
{
    if (!_permissions)
    {
        //
        // TODO: Mobile Data
        // Ask for permission execution.
        //
        
        //
        // Create permission objects
        //
        
        NSMutableArray *permissions = [NSMutableArray array];
        
        [permissions addObject:@[
            [ALPHABluetoothPermission new],
            [ALPHAEventPermission new],
            [ALPHAVideoPermission new],
            [ALPHAContactPermission new],
            [ALPHAHomePermission new],
            [ALPHALocationPermission new],
            [ALPHAAudioPermission new],
            [ALPHAMobileDataPermission new],
            [ALPHAMotionPermission new],
            [ALPHANotificationPermission new],
            [ALPHAAssetPermission new],
            [ALPHAEventPermission reminderPermission]
        ]];
        
        [permissions addObject:[ALPHATCCPermission allPermissions]];
        
        [permissions addObject:[ALPHAHealthPermission allPermissions]];
        [permissions addObject:[ALPHASocialPermission allPermissions]];
        
        _permissions = permissions.copy;
    }
    
    return _permissions;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAPermissionDataIdentifier];
        
        [self addActionIdentifier:ALPHAActionPermissionRequestIdentifier];
        //[self addActionIdentifier:ALPHAActionPermissionResetIdentifier];
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
    
    //
    // Action
    //
    /*ALPHABlockActionItem *resetAction = [ALPHABlockActionItem itemWithIdentifier:ALPHAActionPermissionResetIdentifier];
    resetAction.title = @"Reset All";
    resetAction.actionBlock = ^id (UIBarButtonItem *sender)
    {
        [self resetPermissions];
        
        return nil;
    };
    
    dataModel.rightAction = resetAction;*/
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSUInteger index = -1;
    
    for (NSArray *permissions in self.permissions)
    {
        index++;
        
        if (!permissions.count)
        {
            continue;
        }
        
        [array addObject:[self sectionForPermissions:permissions atIndex:index]];
    }
    
    dataModel.sections = array.copy;
    
    return dataModel;
}

#pragma mark - Private Methods

- (ALPHAScreenSection *)sectionForPermissions:(NSArray *)permissions atIndex:(NSUInteger)index
{
    NSString *sectionIdentifier = nil;
    NSString *sectionHeader = nil;
    
    switch (index)
    {
        case 0:
            sectionIdentifier = @"com.unifiedsense.alpha.data.permission.global";
            sectionHeader = @"Global";
            break;
        
        case 1:
            sectionIdentifier = @"com.unifiedsense.alpha.data.permission.tcc";
            sectionHeader = @"TCC";
            break;
            
        case 2:
            sectionIdentifier = @"com.unifiedsense.alpha.data.permission.health";
            sectionHeader = @"HealthKit";
            break;
            
        case 3:
            sectionIdentifier = @"com.unifiedsense.alpha.data.permission.social";
            sectionHeader = @"Social Accounts";
            break;
            
        default:
            break;
    }
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:sectionIdentifier];
    section.headerText = sectionHeader;
    section.items = [self itemsForPermissions:permissions];
    
    return section;
}

- (NSArray *)itemsForPermissions:(NSArray *)permissions
{
    NSMutableArray *items = [NSMutableArray array];
    
    for (ALPHAPermission *permission in permissions)
    {
        ALPHARequest *request = [ALPHARequest requestWithIdentifier:ALPHAActionPermissionRequestIdentifier parameters:@{ ALPHAActionPermissionRequestPermissionIdentifier : permission.identifier }];
        
        ALPHASelectorActionItem *item = [[ALPHASelectorActionItem alloc] initWithRequest:request];
        item.title = [permission name];
        item.detail = [permission statusString];
        item.style = UITableViewCellStyleValue1;
        
        [items addObject:item];
    }
    
    return items;
}

- (void)resetPermissions
{
    for (NSArray* permissions in self.permissions)
    {
        for (ALPHAPermission *permission in permissions)
        {
            [permission resetPermission:^(BOOL success)
            {
                if (success)
                {
                    //NSLog(@"RESET PERMISSION: %d", (int)success);
                }
            }];
        }
    }
}

- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceRequestCompletion)completion
{
    if (![action.request.identifier isEqualToString:ALPHAActionPermissionRequestIdentifier])
    {
        [super performAction:action completion:completion];
    }
    else
    {
        NSString* identifier = action.request.parameters[ALPHAActionPermissionRequestPermissionIdentifier];
        
        for (NSArray *permissions in self.permissions)
        {
            for (ALPHAPermission *permission in permissions)
            {
                if (![permission.identifier isEqualToString:identifier])
                {
                    continue;
                }
                
                [permission requestPermission:^(ALPHAPermission *permission, ALPHAApplicationAuthorizationStatus status, NSError *error)
                {
                    if (completion)
                    {
                        completion(nil, nil);
                    }
                }];
            }
        }
    }
}

@end
