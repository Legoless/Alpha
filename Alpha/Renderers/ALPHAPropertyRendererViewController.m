//
//  ALPHAPropertyRendererViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAPropertyRendererViewController.h"
#import "ALPHARuntimeUtility.h"
#import "ALPHAFieldEditorView.h"
#import "ALPHAArgumentInputView.h"
#import "ALPHAArgumentInputViewFactory.h"
#import "ALPHAArgumentInputSwitchView.h"

#import "ALPHAObjectActionItem.h"

@interface ALPHAPropertyRendererViewController () <ALPHAArgumentInputViewDelegate>

@end

@implementation ALPHAPropertyRendererViewController

#pragma mark - Getters and Setters

- (ALPHAObjectProperty *)property
{
    if ([self.object isKindOfClass:[ALPHAObjectProperty class]])
    {
        return (ALPHAObjectProperty *)self.object;
    }
    
    return nil;
}

- (void)updateView
{
    [super updateView];
    
    self.title = @"Property";
    
    [self updateViewWithProperty:self.property];
}

- (void)updateViewWithProperty:(ALPHAObjectProperty *)property
{
    self.fieldEditorView.fieldDescription = property.prettyDescription;
    self.setterButton.enabled = [[self class] canEditProperty:property];
    
    const char *typeEncoding = [property.type.cType UTF8String];
    ALPHAArgumentInputView *inputView = [ALPHAArgumentInputViewFactory argumentInputViewForTypeEncoding:typeEncoding];
    inputView.backgroundColor = self.view.backgroundColor;
    inputView.inputValue = property.value;
    inputView.delegate = self;
    
    self.fieldEditorView.argumentInputViews = @[ inputView ];
    
    // Don't show a "set" button for switches - just call the setter immediately after the switch toggles.
    
    if ([inputView isKindOfClass:[ALPHAArgumentInputSwitchView class]])
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - UIViewController

#pragma mark - ALPHAFieldEditorViewController

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    id userInputObject = self.firstInputView.inputValue;

    //
    // Create object action
    //
    
    ALPHAObjectActionItem *action = [[ALPHAObjectActionItem alloc] init];
    action.objectClass = self.property.objectClass;
    action.objectPointer = self.property.objectPointer;
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

- (void)argumentInputViewValueDidChange:(ALPHAArgumentInputView *)argumentInputView
{
    if ([argumentInputView isKindOfClass:[ALPHAArgumentInputSwitchView class]])
    {
        [self actionButtonPressed:nil];
    }
}

+ (BOOL)canEditProperty:(ALPHAObjectProperty *)property
{
    const char *typeEncoding = [property.type.cType UTF8String];
    BOOL canEditType = [ALPHAArgumentInputViewFactory canEditFieldWithTypeEncoding:typeEncoding currentValue:property.value];
    BOOL isReadonly = property.isReadOnly;
    return canEditType && !isReadonly;
}

@end
