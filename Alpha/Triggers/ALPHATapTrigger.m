//
//  ALPHATapTrigger.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHATrigger+Private.h"

#import "ALPHATapTrigger.h"

NSString *const ALPHATapTriggerKeyWindowChangeKeyPath = @"keyWindow";

@interface ALPHATapTrigger ()

@property (nonatomic, strong, readwrite) UILongPressGestureRecognizer *recognizer;

@end

@implementation ALPHATapTrigger

- (UILongPressGestureRecognizer *)recognizer
{
    if (!_recognizer)
    {
        _recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(trigger:)];
        _recognizer.numberOfTouchesRequired = 3;
        _recognizer.minimumPressDuration = 3.0;
    }
    
    return _recognizer;
}

- (void)dealloc
{
    //[[UIApplication sharedApplication] removeObserver:self forKeyPath:ALPHATapTriggerKeyWindowChangeKeyPath];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    UIWindow *keyWindow = [ALPHATrigger keyWindow];
    
    if (!keyWindow)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
        //[[UIApplication sharedApplication] addObserver:self forKeyPath:ALPHATapTriggerKeyWindowChangeKeyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    else
    {
        if (enabled)
        {
            [keyWindow addGestureRecognizer:self.recognizer];
        }
        else
        {
            [keyWindow removeGestureRecognizer:self.recognizer];
            
            self.recognizer = nil;
        }
    }
}

- (void)applicationNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:UIApplicationDidFinishLaunchingNotification] && self.enabled)
    {
        [self updateTriggerWindow:[ALPHATrigger keyWindow]];
    }
}

/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:ALPHATapTriggerKeyWindowChangeKeyPath])
    {
        return;
    }
    
    id changedWindow = change[NSKeyValueChangeNewKey];
    
    //
    // Ignore ALPHAWindow
    //
    if ([changedWindow isKindOfClass:NSClassFromString(@"ALPHAWindow")])
    {
        return;
    }
    else if ([changedWindow isKindOfClass:[UIWindow class]])
    {
        UIWindow* window = changedWindow;
        
        if (![window.gestureRecognizers containsObject:self.recognizer] && self.enabled)
        {
            [window addGestureRecognizer:self.recognizer];
        }
        
        //
        // Usually only do this once
        //
        [[UIApplication sharedApplication] removeObserver:self forKeyPath:ALPHATapTriggerKeyWindowChangeKeyPath];
    }
}
*/

- (void)updateTriggerWindow:(UIWindow *)window
{
    //
    // Ignore ALPHAWindow
    //
    if ([window isKindOfClass:NSClassFromString(@"ALPHAWindow")])
    {
        return;
    }
    
    if (![window.gestureRecognizers containsObject:self.recognizer] && self.enabled)
    {
        [window addGestureRecognizer:self.recognizer];
    }
        
    //
    // Usually only do this once
    //
    //[[UIApplication sharedApplication] removeObserver:self forKeyPath:ALPHATapTriggerKeyWindowChangeKeyPath];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
