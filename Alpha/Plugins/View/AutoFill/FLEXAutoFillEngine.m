//
//  FLEXAutoFillEngine.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXAutoFillEngine.h"

@implementation FLEXAutoFillEngine

+ (instancetype)sharedEngine
{
    static FLEXAutoFillEngine *sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEngine = [[[self class] alloc] init];
    });
    return sharedEngine;
}

- (void)autoFillView:(UIView *)view
{
    id autoFillView = [self editableViewForAutoFillView:view];
    
    //
    // Ignore empty
    //
    if (!autoFillView)
    {
        return;
    }
    
    [autoFillView setText:@"TEst"];
}

- (NSArray *)editableViewsInView:(UIView *)view
{
    //
    // Go through children and find editable views
    //
    return @[];
}

- (UIView *)editableViewForAutoFillView:(UIView *)view
{
    UIView* targetView = view;
    
    while (![self isEditableView:targetView] && targetView != nil)
    {
        targetView = targetView.superview;
    }
    
    if ([self isEditableView:targetView])
    {
        return targetView;
    }
    
    return nil;
}

- (BOOL)isEditableView:(UIView *)view
{
    if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *textField = (UITextField *)view;
        
        id<UITextFieldDelegate> delegate = textField.delegate;
        
        if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        {
            return [delegate textFieldShouldBeginEditing:textField];
        }
        
        return YES;
    }
    else if ([view isKindOfClass:[UITextView class]])
    {
        UITextView *textView = (UITextView *)view;
        
        id<UITextViewDelegate> delegate = textView.delegate;
        
        if ([delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        {
            return [delegate textViewShouldBeginEditing:textView];
        }
        
        return YES;
    }
    
    return NO;
}

@end
