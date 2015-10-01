//
//  ALPHAGlobalSource.m
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAGlobalSource.h"
#import "ALPHAClassSource.h"
#import "ALPHALibrarySource.h"

#import "ALPHARuntimeUtility.h"

#import "ALPHAApplicationDelegate.h"
#import "ALPHAModel.h"
#import "ALPHATableScreenModel.h"
#import "ALPHAActions.h"
#import "ALPHAManager.h"

NSString* const ALPHAGlobalDataIdentifier = @"com.unifiedsense.alpha.data.global";

@implementation ALPHAGlobalSource

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAGlobalDataIdentifier];
    }
    
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request
{
    
    NSMutableArray *items = [NSMutableArray array];
    
    ALPHAScreenActionItem* menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.classes"];
    menuAction.title = [NSString stringWithFormat:@"%@ Classes", [ALPHARuntimeUtility applicationName]];
    menuAction.icon = @"📕";
    menuAction.dataIdentifier = ALPHAClassDataIdentifier;
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.system.libraries"];
    menuAction.title = @"System Libraries";
    menuAction.icon = @"📚";
    menuAction.dataIdentifier = ALPHALibraryDataIdentifier;
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.delegate"];
    menuAction.title = NSStringFromClass([[self delegate] class]);
    menuAction.icon = @"👉";
    menuAction.object = [ALPHARequest requestForObject:[self delegate]];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = NSStringFromClass([[[ALPHAManager defaultManager].keyWindow rootViewController] class]);
    menuAction.icon = @"🌴";
    menuAction.object = [ALPHARequest requestForObject:[[ALPHAManager defaultManager].keyWindow rootViewController]];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.userDefaults"];
    menuAction.title = @"+ [NSUserDefaults standardUserDefaults]";
    menuAction.icon = @"🚶";
    menuAction.object = [ALPHARequest requestForObject:[NSUserDefaults standardUserDefaults]];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.sharedApplication"];
    menuAction.title = @"+ [UIApplication sharedApplication]";
    menuAction.icon = @"💾";
    menuAction.object = [ALPHARequest requestForObject:[UIApplication sharedApplication]];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = @"- [UIApplication keyWindow]";
    menuAction.icon = @"🔑";
    menuAction.object = [ALPHARequest requestForObject:[ALPHAManager defaultManager].keyWindow];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = @"+ [UIScreen mainScreen]";
    menuAction.icon = @"💻";
    menuAction.object = [ALPHARequest requestForObject:[UIScreen mainScreen]];
    
    [items addObject:menuAction];
    
    menuAction = [ALPHAScreenActionItem itemWithIdentifier:@"com.unifiedsense.alpha.global.rootViewController"];
    menuAction.title = @"+ [UIDevice currentDevice]";
    menuAction.icon = @"📱";
    menuAction.object = [ALPHARequest requestForObject:[UIDevice currentDevice]];
    
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
