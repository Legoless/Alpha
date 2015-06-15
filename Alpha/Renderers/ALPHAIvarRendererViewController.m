//
//  ALPHAIvarRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHAIvarRendererViewController.h"
#import "ALPHAFieldEditorView.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXArgumentInputView.h"
#import "FLEXArgumentInputViewFactory.h"
#import "FLEXArgumentInputSwitchView.h"

#import "ALPHAObjectActionItem.h"

@interface ALPHAIvarRendererViewController () <FLEXArgumentInputViewDelegate>

@end

@implementation ALPHAIvarRendererViewController

#pragma mark - Getters and Setters

- (ALPHAObjectIvar *)ivar
{
    if ([self.object isKindOfClass:[ALPHAObjectIvar class]])
    {
        return (ALPHAObjectIvar *)self.object;
    }
    
    return nil;
}

- (void)updateView
{
    [super updateView];
    
    self.title = @"Instance Variable";
    
    [self updateViewWithIvar:self.ivar];
}

- (void)updateViewWithIvar:(ALPHAObjectIvar *)ivar
{
    self.fieldEditorView.fieldDescription = [self.ivar prettyDescription];
    
    const char *typeEncoding = [ivar.type.cType UTF8String];
    
    FLEXArgumentInputView *inputView = [FLEXArgumentInputViewFactory argumentInputViewForTypeEncoding:typeEncoding];
    inputView.backgroundColor = self.view.backgroundColor;
    inputView.inputValue = ivar.convertedValue;
    inputView.delegate = self;
    
    self.fieldEditorView.argumentInputViews = @[ inputView ];
    
    // Don't show a "set" button for switches. Set the ivar when the switch toggles.
    if ([inputView isKindOfClass:[FLEXArgumentInputSwitchView class]])
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - UIViewController

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    ALPHAObjectActionItem *action = [[ALPHAObjectActionItem alloc] init];
    action.objectClass = self.ivar.objectClass;
    action.objectPointer = self.ivar.objectPointer;
    
    action.ivar = self.ivar.name;
    action.arguments = self.firstInputView.inputValue ? @[ self.firstInputView.inputValue ] : nil;
    
    [self.source performAction:action completion:^(id model, NSError *error)
    {
        if (error)
        {
            NSString *title = @"Ivar Set Failed";
            NSString *message = [error localizedDescription];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            // If the setter was called without error, pop the view controller to indicate that and make the user's life easier.
            // Don't do this for simulated taps on the action button (i.e. from switch/BOOL editors). The experience is weird there.
            if (sender)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

- (void)argumentInputViewValueDidChange:(FLEXArgumentInputView *)argumentInputView
{
    if ([argumentInputView isKindOfClass:[FLEXArgumentInputSwitchView class]])
    {
        [self actionButtonPressed:nil];
    }
}

+ (BOOL)canEditIvar:(ALPHAObjectIvar *)ivar
{
    const char *typeEncoding = [ivar.type.cType UTF8String];
    
    return [FLEXArgumentInputViewFactory canEditFieldWithTypeEncoding:typeEncoding currentValue:ivar.value];
}

@end
