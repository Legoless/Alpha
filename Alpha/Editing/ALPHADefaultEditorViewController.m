//
//  ALPHADefaultEditorViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADefaultEditorViewController.h"
#import "FLEXFieldEditorView.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXArgumentInputView.h"
#import "FLEXArgumentInputViewFactory.h"

@interface ALPHADefaultEditorViewController ()

@property (nonatomic, readonly) NSUserDefaults *defaults;
@property (nonatomic, strong) NSString *key;

@end

@implementation ALPHADefaultEditorViewController

- (id)initWithSource:(id<ALPHADataSource>)source objectTarget:(ALPHAObjectModel *)target
{
    self = [super initWithSource:source objectTarget:target];
    
    if (self)
    {
        self.title = @"Edit Default";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fieldEditorView.fieldDescription = self.key;

    id currentValue = [self.defaults objectForKey:self.key];
    FLEXArgumentInputView *inputView = [FLEXArgumentInputViewFactory argumentInputViewForTypeEncoding:@encode(id) currentValue:currentValue];
    inputView.backgroundColor = self.view.backgroundColor;
    inputView.inputValue = currentValue;
    self.fieldEditorView.argumentInputViews = @[inputView];
}

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    id value = self.firstInputView.inputValue;
    if (value) {
        [self.defaults setObject:value forKey:self.key];
    } else {
        [self.defaults removeObjectForKey:self.key];
    }
    [self.defaults synchronize];

    self.firstInputView.inputValue = [self.defaults objectForKey:self.key];
}

+ (BOOL)canEditDefaultWithValue:(id)currentValue
{
    return [FLEXArgumentInputViewFactory canEditFieldWithTypeEncoding:@encode(id) currentValue:currentValue];
}

@end
