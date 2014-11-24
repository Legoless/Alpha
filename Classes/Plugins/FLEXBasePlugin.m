//
//  FLEXBasePlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXManager.h"

#import "FLEXActionItem.h"
#import "FLEXResources.h"

#import "FLEXBasePlugin.h"

@interface FLEXBasePlugin ()

@property (nonatomic, strong) NSArray* baseActions;

@end

@implementation FLEXBasePlugin

- (NSArray *)actions
{
    return self.baseActions;
}

- (BOOL)isEnabled
{
    return YES;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        FLEXActionItem *closeAction = [FLEXActionItem actionItemWithIdentifier:@"com.flex.close"];
        closeAction.title = @"Close";
        closeAction.image = [FLEXResources closeIcon];
        closeAction.action = ^(id sender){
            [[FLEXManager sharedManager] hideExplorer];
        };
        closeAction.enabled = YES;
        
        self.baseActions = @[ closeAction ];
    }
    
    return self;
}


@end
