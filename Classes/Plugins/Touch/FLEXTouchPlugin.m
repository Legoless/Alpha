//
//  FLEXTouchPlugin.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXTouchPlugin.h"

#import "FLEXResources.h"
#import "UIApplication+FLEXEvent.h"

#import "FLEXTouchWindow.h"

@interface FLEXTouchPlugin ()

@property (nonatomic, strong) FLEXTouchWindow *touchWindow;

@end

@implementation FLEXTouchPlugin

- (FLEXTouchWindow *)touchWindow
{
    if (!_touchWindow)
    {
        _touchWindow = [[FLEXTouchWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _touchWindow.rootViewController = [UIViewController new];
    }
    
    return _touchWindow;
}

- (void)setShouldDisplayTouches:(BOOL)shouldDisplayTouches
{
    _shouldDisplayTouches = shouldDisplayTouches;
    
    if (!self.touchWindow.isKeyWindow)
    {
        [self.touchWindow makeKeyAndVisible];
    }
    
    self.touchWindow.hidden = !_shouldDisplayTouches;
}

#pragma mark - Initializers

- (id)init
{
    self = [super init];
    
    if (self)
    {
        FLEXActionItem *touchAction = [FLEXActionItem actionItemWithIdentifier:@"com.flex.touch.touches"];
        touchAction.title = @"Touches";
        touchAction.image = [FLEXResources selectIcon];
        touchAction.action = ^(id sender){
            self.shouldDisplayTouches = !self.shouldDisplayTouches;
        };
        touchAction.enabled = YES;

        [self registerAction:touchAction];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterfaceEvent:) name:FLEXInterfaceEventNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleInterfaceEvent:(NSNotification *)notification
{
    if (self.shouldDisplayTouches && [notification.object isKindOfClass:[UIEvent class]])
    {
        UIEvent* event = notification.object;
        
        if (event.type == UIEventTypeTouches)
        {
            [self.touchWindow displayEvent:event];
        }
    }
}

@end
