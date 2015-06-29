//
//  ALPHATapTrigger.m
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHATrigger+Private.h"

#import "ALPHATapTrigger.h"

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

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    UIWindow *keyWindow = [ALPHATrigger keyWindow];
    
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

@end
