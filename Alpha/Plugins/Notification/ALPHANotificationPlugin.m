//
//  ALPHANotificationPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 2/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHANotificationPlugin.h"
#import "ALPHAScreenActionItem.h"
#import "ALPHANotificationSource.h"
#import "ALPHANotificationIcon.h"
#import "ALPHAAssetManager.h"

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
        
        ALPHAScreenActionItem *menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.notification.notifications"];
        menuAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconNotificationIdentifier color:nil size:CGSizeMake(20.0, 20.0)];
        menuAction.title = @"Notifications";
        menuAction.dataIdentifier = ALPHANotificationDataIdentifier;
        menuAction.isMain = YES;
        
        [self registerAction:menuAction];
        
        //
        // Collectors
        //
        
        [self registerSource:[ALPHANotificationSource new]];
    }
    
    return self;
}

@end
