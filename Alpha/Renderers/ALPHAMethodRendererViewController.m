//
//  ALPHAMethodRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAMethodRendererViewController.h"
#import "ALPHARuntimeUtility.h"
#import "ALPHAFieldEditorView.h"
#import "ALPHAArgumentInputView.h"
#import "ALPHAArgumentInputViewFactory.h"
#import "ALPHAObjectActionItem.h"

#import "ALPHAScreenManager.h"

@interface ALPHAMethodRendererViewController ()

@end

@implementation ALPHAMethodRendererViewController

#pragma mark - Getters and Setters

- (ALPHAObjectMethod *)method
{
    if ([self.object isKindOfClass:[ALPHAObjectMethod class]])
    {
        return (ALPHAObjectMethod *)self.object;
    }
    
    return nil;
}

- (void)updateView
{
    [super updateView];
    
    [self updateViewWithMethod:self.method];
}

- (void)updateViewWithMethod:(ALPHAObjectMethod *)method
{
    self.title = method.isClassMethod ? @"Class Method" : @"Method";
    
    self.fieldEditorView.fieldDescription = [self.method prettyDescription];
    
    NSMutableArray *argumentInputViews = [NSMutableArray array];
    
    unsigned int argumentIndex = ALPHANumberOfImplicitArgsKey;
    
    for (ALPHAObjectArgument *methodComponent in self.method.arguments)
    {
        const char *typeEncoding = [self.method.returnType.cType UTF8String];
        ALPHAArgumentInputView *inputView = [ALPHAArgumentInputViewFactory argumentInputViewForTypeEncoding:typeEncoding];
        
        inputView.backgroundColor = self.theme.backgroundColor;
        inputView.title = methodComponent.prettyDescription;
        
        [argumentInputViews addObject:inputView];
        argumentIndex++;
    }
    
    self.fieldEditorView.argumentInputViews = argumentInputViews;
}

#pragma mark - UIViewController

#pragma mark - ALPHAFieldEditorViewController

- (NSString *)titleForActionButton
{
    return @"Call";
}

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    NSMutableArray *arguments = [NSMutableArray array];
    
    for (ALPHAArgumentInputView *inputView in self.fieldEditorView.argumentInputViews)
    {
        id argumentValue = inputView.inputValue;
        
        if (!argumentValue)
        {
            // Use NSNulls as placeholders in the array. They will be interpreted as nil arguments.
            argumentValue = [NSNull null];
        }
        
        [arguments addObject:argumentValue];
    }
    
    ALPHAObjectActionItem *action = [[ALPHAObjectActionItem alloc] init];
    action.objectClass = self.method.objectClass;
    action.objectPointer = self.method.objectPointer;
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
