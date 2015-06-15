//
//  ALPHAPropertyEditorViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAPropertyEditorViewController.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXFieldEditorView.h"
#import "FLEXArgumentInputView.h"
#import "FLEXArgumentInputViewFactory.h"
#import "FLEXArgumentInputSwitchView.h"

#import "ALPHAObjectActionItem.h"

@interface ALPHAPropertyEditorViewController () <FLEXArgumentInputViewDelegate>

@end

@implementation ALPHAPropertyEditorViewController

#pragma mark - Getters and Setters

- (void)setProperty:(ALPHAObjectProperty *)property
{
    _property = property;
    
    if (self.isViewLoaded)
    {
        [self updateViewWithProperty:property];
    }
}

- (void)updateViewWithProperty:(ALPHAObjectProperty *)property
{
    self.fieldEditorView.fieldDescription = property.prettyDescription;
    self.setterButton.enabled = [[self class] canEditProperty:property];
    
    const char *typeEncoding = [property.type.cType UTF8String];
    FLEXArgumentInputView *inputView = [FLEXArgumentInputViewFactory argumentInputViewForTypeEncoding:typeEncoding];
    inputView.backgroundColor = self.view.backgroundColor;
    inputView.inputValue = property.value;
    inputView.delegate = self;
    
    self.fieldEditorView.argumentInputViews = @[ inputView ];
    
    // Don't show a "set" button for switches - just call the setter immediately after the switch toggles.
    
    if ([inputView isKindOfClass:[FLEXArgumentInputSwitchView class]])
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.title = @"Property";
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.property)
    {
        [self updateViewWithProperty:self.property];
    }
}

#pragma mark - ALPHAFieldEditorViewController

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    id userInputObject = self.firstInputView.inputValue;

    //
    // Create object action
    //
    
    ALPHAObjectActionItem *action = [[ALPHAObjectActionItem alloc] initWithObjectModel:self.target];
    action.selector = self.property.setter;
    action.arguments = userInputObject ? @[ userInputObject ] : nil;
    
    [self.source performAction:action completion:^(id model, NSError *error)
    {
        if (error)
        {
            NSString *title = @"Property Setter Failed";
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

+ (BOOL)canEditProperty:(ALPHAObjectProperty *)property
{
    const char *typeEncoding = [property.type.cType UTF8String];
    BOOL canEditType = [FLEXArgumentInputViewFactory canEditFieldWithTypeEncoding:typeEncoding currentValue:property.value];
    BOOL isReadonly = property.isReadOnly;
    return canEditType && !isReadonly;
}

@end
