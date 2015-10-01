//
//  ALPHABonjourServerSource.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHABonjourServerSource.h"
#import "ALPHABonjourConfig.h"
#import "ALPHATableScreenModel.h"
#import "ALPHABonjourConnection.h"
#import "ALPHABonjourSource.h"
#import "ALPHAMenuSource.h"

#import "ALPHAActions.h"

NSString *const ALPHABonjourServerDataIdentifier = @"com.unifiedsense.alpha.data.bonjour";

@interface ALPHABonjourServerSource () <NSNetServiceBrowserDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) NSNetServiceBrowser *browser;

@property (nonatomic, strong) NSMutableArray *allServices;
@property (nonatomic, strong) NSMutableArray *services;

@end

@implementation ALPHABonjourServerSource

#pragma mark - Getters and Setters

- (NSMutableArray *)allServices
{
    if (!_allServices)
    {
        _allServices = [NSMutableArray array];
    }
    
    return _allServices;
}

- (NSMutableArray *)services
{
    if (!_services)
    {
        _services = [NSMutableArray array];
    }
    
    return _services;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHABonjourServerDataIdentifier];
        
        self.browser = [[NSNetServiceBrowser alloc] init];
        self.browser.delegate = self;
        [self.browser searchForServicesOfType:ALPHABonjourType inDomain:@""];
    }
    
    return self;
}

#pragma mark - ALPHABaseDataSource

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHABonjourServerDataIdentifier];
    screenModel.title = @"Devices";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (ALPHABonjourConnection* service in self.services)
    {
        ALPHAScreenActionItem* item = [[ALPHAScreenActionItem alloc] initWithIdentifier:service.name];
        
        if ([service.type containsString:@"iPhone"])
        {
            item.icon = @"📱";
        }
        else
        {
            item.icon = @"💻";
        }
        
        item.title = service.name;
        item.detail = [NSString stringWithFormat:@"      %@ %@", service.system, service.version];
        
        item.dataIdentifier = ALPHAMenuDataIdentifier;
        item.source = [[ALPHABonjourSource alloc] initWithConnection:service];
        
        item.style = UITableViewCellStyleSubtitle;
        
        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    screenModel.expiration = 5.0;
    
    return screenModel;
}

#pragma mark - NetServiceBrowser Delegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    
    aNetService.delegate = self;
    [aNetService startMonitoring];
    
    [self.allServices addObject:aNetService];
    
    if (!moreComing)
    {
        [self updateServices];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    [self.allServices removeObject:aNetService];
    
    //
    // Search for services connection and remove it
    //
    
    ALPHABonjourConnection* connectionToRemove = nil;
    
    for (ALPHABonjourConnection *connection in self.services)
    {
        if (connection.service == aNetService)
        {
            connectionToRemove = connection;
            break;
        }
    }
    
    [self.services removeObject:connectionToRemove];
}

#pragma mark - NSNetService Delegate

- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data
{
    [self updateServices];
    
    [sender stopMonitoring];
}

#pragma mark - Private methods

- (void)updateServices
{
    [self.services removeAllObjects];
    
    for (NSNetService *service in [self.allServices copy])
    {
        NSDictionary *dict = [NSNetService dictionaryFromTXTRecordData:service.TXTRecordData];
        
        if (!dict)
        {
            continue;
        }
        
        NSString *device = [[NSString alloc] initWithData:dict[@"Device"] encoding:NSUTF8StringEncoding];
        
        if (![device isEqualToString:[[UIDevice currentDevice] name]])
        {
            ALPHABonjourConnection *connection = [[ALPHABonjourConnection alloc] initWithService:service];
            [self.services addObject:connection];
        }
    }
}


@end
