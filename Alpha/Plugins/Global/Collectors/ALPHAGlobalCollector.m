//
//  ALPHAGlobalCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAGlobalCollector.h"
#import "ALPHAClassCollector.h"

#import "FLEXUtility.h"

#import "ALPHAApplicationDelegate.h"
#import "ALPHAModel.h"
#import "ALPHATableScreenModel.h"
#import "ALPHAActions.h"
#import "ALPHAManager.h"

NSString* const ALPHAGlobalDataIdentifier = @"com.unifiedsense.alpha.data.global";

@implementation ALPHAGlobalCollector

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAGlobalDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)model
{
    
    NSMutableArray *items = [NSMutableArray array];
    
    ALPHAMenuActionItem* menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.classes"];
    menuAction.title = [NSString stringWithFormat:@"%@ Classes", [FLEXUtility applicationName]];
    menuAction.icon = @"📕";
    menuAction.dataIdentifier = ALPHAClassDataIdentifier;
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.system.libraries"];
    menuAction.title = @"System Libraries";
    menuAction.icon = @"📚";
    menuAction.viewControllerClass = @"FLEXLibrariesTableViewController";
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.delegate"];
    menuAction.title = NSStringFromClass([[self delegate] class]);
    menuAction.icon = @"👉";
    menuAction.object = [self delegate];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = NSStringFromClass([[[ALPHAManager sharedManager].keyWindow rootViewController] class]);
    menuAction.icon = @"🌴";
    menuAction.object = [[ALPHAManager sharedManager].keyWindow rootViewController];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.userDefaults"];
    menuAction.title = @"+ [NSUserDefaults standardUserDefaults]";
    menuAction.icon = @"🚶";
    menuAction.object = [NSUserDefaults standardUserDefaults];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.sharedApplication"];
    menuAction.title = @"+ [UIApplication sharedApplication]";
    menuAction.icon = @"💾";
    menuAction.object = [UIApplication sharedApplication];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = @"- [UIApplication keyWindow]";
    menuAction.icon = @"🔑";
    menuAction.object = [ALPHAManager sharedManager].keyWindow;
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = @"+ [UIScreen mainScreen]";
    menuAction.icon = @"💻";
    menuAction.object = [UIScreen mainScreen];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAMenuActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = @"+ [UIDevice currentDevice]";
    menuAction.icon = @"📱";
    menuAction.object = [UIDevice currentDevice];
    
    [items addObject:menuAction];
    
    //
    // Section & Model
    //
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] initWithIdentifier:ALPHAGlobalDataIdentifier];
    section.items = items.copy;
    
    ALPHATableScreenModel* model = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAGlobalDataIdentifier];
    model.title = @"Global State";
    
    model.sections = @[ section ];

    return model;
}

- (id)delegate
{
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate isKindOfClass:[ALPHAApplicationDelegate class]])
    {
        delegate = [delegate object];
    }
    
    return delegate;
}


@end
