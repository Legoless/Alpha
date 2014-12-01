//
//  FLEXWidgetPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 01/12/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXWidgetPlugin.h"

@implementation FLEXWidgetPlugin

- (id)init
{
    self = [super initWithIdentifier:@"com.flex.widget"];
    
    if (self)
    {
        //
        // Close action always present
        //
        
        /*FLEXActionItem *closeAction = [FLEXActionItem itemWithIdentifier:@"com.flex.close"];
        closeAction.title = @"Close";
        closeAction.icon = [FLEXResources closeIcon];
        closeAction.action = ^(id sender){
            [[FLEXManager sharedManager] setHidden:YES];
        };
        
        FLEXActionItem *infoAction = [FLEXActionItem itemWithIdentifier:@"com.flex.info"];
        infoAction.title = @"Info";
        infoAction.icon = [FLEXResources globeIcon];
        infoAction.action = ^(id sender){
            [self.explorerViewController displayInfoTable];
        };
        
        [self registerAction:infoAction];
        [self registerAction:closeAction];
        
        //
        // Base view controllers
        //
        
        [self registerMenuActions];*/
    }
    
    return self;
}


@end
