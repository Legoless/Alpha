//
//  ALPHAAppsListSource.m
//  Alpha
//
//  Created by odnairy on 19/07/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAAppsListSource.h"
#import "ALPHATableScreenModel.h"
#import <objc/runtime.h>

// private headers
#import "LSApplicationWorkspace.h"
#import "LSApplicationProxy.h"
#import "UIImage+UIApplicationIconPrivate.h"

NSString *const ALPHAAppsListDataIdentifier = @"com.odnairy.alpha.data.applicationslist";


@interface ALPHAAppsListSource ()
@property (nonatomic, strong) NSArray* applicationsList;
@end

@implementation ALPHAAppsListSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAAppsListDataIdentifier];
    }
    
    return self;
}

-(void)loadApplications{
    self.applicationsList =  [[objc_getClass("LSApplicationWorkspace") defaultWorkspace] allApplications];
    
    self.applicationsList = [self.applicationsList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(LSApplicationProxy*  __nonnull evaluatedObject, NSDictionary<NSString *,id> * __nullable bindings) {
        return [self titleForApplication:evaluatedObject].length > 0;
    }]];
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    [self loadApplications];
    
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAAppsListDataIdentifier];
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

-(NSString*)titleForApplication:(LSApplicationProxy*)applicationProxy{
    return [applicationProxy localizedShortName];
}

@end
