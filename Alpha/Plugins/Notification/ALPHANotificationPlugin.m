//
//  ALPHANotificationPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 2/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHANotificationPlugin.h"
#import "ALPHAMenuActionItem.h"
#import "ALPHANotificationCollector.h"

@interface ALPHANotificationPlugin ()

@end

@implementation ALPHANotificationPlugin

- (instancetype)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.notification"];
    
    if (self)
    {
        //
        // Menu items
        //
        
        ALPHAMenuActionItem *menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.notification.notifications"];
        menuAction.icon = @"🔔";
        menuAction.title = @"Notifications";
        menuAction.dataIdentifier = ALPHANotificationDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHANotificationCollector new]];
    }
    
    return self;
}

@end
