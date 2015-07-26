//
//  ALPHAAppsListSource.m
//  Alpha
//
//  Created by odnairy on 19/07/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationSource.h"
#import "ALPHATableScreenModel.h"
#import <objc/runtime.h>

//
// Private headers
//
#import "LSApplicationWorkspace.h"
#import "LSApplicationProxy.h"
#import "UIImage+UIApplicationIconPrivate.h"

NSString *const ALPHAApplicationDataIdentifier = @"com.odnairy.alpha.data.application";

@interface ALPHAApplicationSource ()

@property (nonatomic, strong) NSArray* applicationsList;

@end

@implementation ALPHAApplicationSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAApplicationDataIdentifier];
    }
    
    return self;
}

- (NSArray *)availableScopes
{
    NSArray* scopes = @[ @"User", @"System" ];
    
    if ([self applicationsOfType:$_LSInternalApplicationType].count)
    {
        scopes = [scopes arrayByAddingObject:@"Internal"];
    }
    return scopes;
}

- (NSArray *)applicationsOfType:(_ApplicationType)appType
{
    NSArray* apps = [[objc_getClass("LSApplicationWorkspace") defaultWorkspace] applicationsOfType:appType];
    apps = [apps filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(LSApplicationProxy *evaluatedObject, NSDictionary *bindings)
    {
        return [self titleForApplication:evaluatedObject].length > 0;
    }]];
    
    return apps;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    NSUInteger selectedScope = [request.parameters[ALPHASearchScopeParameterKey] unsignedIntegerValue];
    _ApplicationType appType = $_LSUserApplicationType;
    
    if (selectedScope == 1)
    {
        appType = $_LSSystemApplicationType;
    }
    else if (selectedScope == 2)
    {
        appType = $_LSInternalApplicationType;
    }
    
    self.applicationsList = [self applicationsOfType:appType];
    
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAApplicationDataIdentifier];
    screenModel.scopes = [self availableScopes];
    screenModel.title = @"Applications List";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (LSApplicationProxy* application in self.applicationsList)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.title = [self titleForApplication:application];
        item.object = [ALPHARequest requestForObject:application];
        item.icon = [UIImage _applicationIconImageForBundleIdentifier:application.applicationIdentifier format:0];
        item.style = UITableViewCellStyleSubtitle;
        
        [item setDetailText:application.applicationIdentifier];
        [item setDetail:application.applicationIdentifier];
        
        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}

- (NSString*)titleForApplication:(LSApplicationProxy*)applicationProxy
{
    return [applicationProxy localizedShortName];
}

@end
