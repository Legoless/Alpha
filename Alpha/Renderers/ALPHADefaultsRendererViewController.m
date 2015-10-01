//
//  ALPHADefaultsRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADefaultsRendererViewController.h"
#import "ALPHAFieldEditorView.h"
#import "ALPHARuntimeUtility.h"
#import "ALPHAArgumentInputView.h"
#import "ALPHAArgumentInputViewFactory.h"

@interface ALPHADefaultsRendererViewController ()

@property (nonatomic, readonly) NSUserDefaults *defaults;
@property (nonatomic, strong) NSString *key;

@end

@implementation ALPHADefaultsRendererViewController

- (id)init
{
    self = [super init];
    
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
    ALPHAArgumentInputView *inputView = [ALPHAArgumentInputViewFactory argumentInputViewForTypeEncoding:@encode(id) currentValue:currentValue];
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
    return [ALPHAArgumentInputViewFactory canEditFieldWithTypeEncoding:@encode(id) currentValue:currentValue];
}

@end
