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

@interface ALPHAMethodCallingViewController ()

@end

@implementation ALPHAMethodCallingViewController

- (void)setMethod:(ALPHAObjectMethod *)method
{
    _method = method;
    
    self.title = method.isClassMethod ? @"Class Method" : @"Method";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fieldEditorView.fieldDescription = [self.method prettyDescription];
    
    NSMutableArray *argumentInputViews = [NSMutableArray array];
    
    unsigned int argumentIndex = kFLEXNumberOfImplicitArgs;
    
    for (ALPHAObjectMethod *methodComponent in self.method.arguments)
    {
        char *argumentTypeEncoding = method_copyArgumentType(self.method, argumentIndex);
        FLEXArgumentInputView *inputView = [FLEXArgumentInputViewFactory argumentInputViewForTypeEncoding:argumentTypeEncoding];
        free(argumentTypeEncoding);
        
        inputView.backgroundColor = self.view.backgroundColor;
        inputView.title = methodComponent;
        [argumentInputViews addObject:inputView];
        argumentIndex++;
    }
    
    self.fieldEditorView.argumentInputViews = argumentInputViews;
}

- (NSString *)titleForActionButton
{
    return @"Call";
}

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    NSMutableArray *arguments = [NSMutableArray array];
    for (FLEXArgumentInputView *inputView in self.fieldEditorView.argumentInputViews) {
        id argumentValue = inputView.inputValue;
        if (!argumentValue) {
            // Use NSNulls as placeholders in the array. They will be interpreted as nil arguments.
            argumentValue = [NSNull null];
        }
        [arguments addObject:argumentValue];
    }
    
    NSError *error = nil;
    id returnedObject = [FLEXRuntimeUtility performSelector:method_getName(self.method) onObject:self.target withArguments:arguments error:&error];
    
    if (error) {
        NSString *title = @"Method Call Failed";
        NSString *message = [error localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (returnedObject) {
        // For non-nil (or void) return types, push an explorer view controller to display the returned object
        FLEXObjectExplorerViewController *explorerViewController = [FLEXObjectExplorerFactory explorerViewControllerForObject:returnedObject];
        [self.navigationController pushViewController:explorerViewController animated:YES];
    } else {
        // If we didn't get a returned object but the method call succeeded,
        // pop this view controller off the stack to indicate that the call went through.
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
