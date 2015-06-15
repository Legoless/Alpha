//
//  ALPHAMethodCallingViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMethodCallingViewController.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXFieldEditorView.h"
#import "FLEXObjectExplorerFactory.h"
#import "FLEXObjectExplorerViewController.h"
#import "FLEXArgumentInputView.h"
#import "FLEXArgumentInputViewFactory.h"
#import "ALPHAObjectActionItem.h"

#import "ALPHAScreenManager.h"

@interface ALPHAMethodCallingViewController ()

@end

@implementation ALPHAMethodCallingViewController

#pragma mark - Getters and Setters

- (void)setMethod:(ALPHAObjectMethod *)method
{
    _method = method;
    
    if (self.isViewLoaded)
    {
        [self updateViewWithMethod:method];
    }
}

- (void)updateViewWithMethod:(ALPHAObjectMethod *)method
{
    self.title = method.isClassMethod ? @"Class Method" : @"Method";
    
    self.fieldEditorView.fieldDescription = [self.method prettyDescription];
    
    NSMutableArray *argumentInputViews = [NSMutableArray array];
    
    unsigned int argumentIndex = kFLEXNumberOfImplicitArgs;
    
    for (ALPHAObjectArgument *methodComponent in self.method.arguments)
    {
        const char *typeEncoding = [self.method.returnType.cType UTF8String];
        FLEXArgumentInputView *inputView = [FLEXArgumentInputViewFactory argumentInputViewForTypeEncoding:typeEncoding];
        
        inputView.backgroundColor = self.view.backgroundColor;
        inputView.title = methodComponent.prettyDescription;
        
        [argumentInputViews addObject:inputView];
        argumentIndex++;
    }
    
    self.fieldEditorView.argumentInputViews = argumentInputViews;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.method)
    {
        [self updateViewWithMethod:self.method];
    }
}

#pragma mark - ALPHAFieldEditorViewController

- (NSString *)titleForActionButton
{
    return @"Call";
}

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    NSMutableArray *arguments = [NSMutableArray array];
    
    for (FLEXArgumentInputView *inputView in self.fieldEditorView.argumentInputViews)
    {
        id argumentValue = inputView.inputValue;
        
        if (!argumentValue)
        {
            // Use NSNulls as placeholders in the array. They will be interpreted as nil arguments.
            argumentValue = [NSNull null];
        }
        
        [arguments addObject:argumentValue];
    }
    
    ALPHAObjectActionItem *action = [[ALPHAObjectActionItem alloc] initWithObjectModel:self.target];
    action.selector = self.method.name;
    action.arguments = arguments;
    
    [self.source performAction:action completion:^(id returnedObject, NSError *error)
    {
        if (error)
        {
            NSString *title = @"Method Call Failed";
            NSString *message = [error localizedDescription];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if (returnedObject)
        {
            //
            // For non-nil (or void) return types, push an explorer view controller to display the returned object
            //
            
            ALPHAScreenManager* manager = [ALPHAScreenManager defaultManager];
            
            [manager pushObject:returnedObject];
        }
        else
        {
            // If we didn't get a returned object but the method call succeeded,
            // pop this view controller off the stack to indicate that the call went through.
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
