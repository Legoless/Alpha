//
//  ALPHAFieldEditorViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFieldEditorViewController.h"
#import "FLEXFieldEditorView.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXUtility.h"
#import "FLEXArgumentInputView.h"
#import "FLEXArgumentInputViewFactory.h"

@interface ALPHAFieldEditorViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong, readwrite) id<ALPHADataSource> source;
@property (nonatomic, strong, readwrite) ALPHAObjectModel *target;
@property (nonatomic, strong, readwrite) FLEXFieldEditorView *fieldEditorView;
@property (nonatomic, strong, readwrite) UIBarButtonItem *setterButton;

@end

@implementation ALPHAFieldEditorViewController

- (id)initWithSource:(id<ALPHADataSource>)source objectTarget:(ALPHAObjectModel *)target
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        self.source = source;
        self.target = target;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect keyboardRectInWindow = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize keyboardSize = [self.view convertRect:keyboardRectInWindow fromView:nil].size;
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = keyboardSize.height;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
    
    // Find the active input view and scroll to make sure it's visible.
    for (FLEXArgumentInputView *argumentInputView in self.fieldEditorView.argumentInputViews)
    {
        if (argumentInputView.inputViewIsFirstResponder)
        {
            CGRect scrollToVisibleRect = [self.scrollView convertRect:argumentInputView.bounds fromView:argumentInputView];
            [self.scrollView scrollRectToVisible:scrollToVisibleRect animated:YES];
            break;
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = 0.0;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [FLEXUtility scrollViewGrayColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = self.view.backgroundColor;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.fieldEditorView = [[FLEXFieldEditorView alloc] init];
    self.fieldEditorView.backgroundColor = self.view.backgroundColor;
    self.fieldEditorView.targetDescription = [NSString stringWithFormat:@"%@ %p", [self.source class], self.source];
    [self.scrollView addSubview:self.fieldEditorView];
    
    self.setterButton = [[UIBarButtonItem alloc] initWithTitle:[self titleForActionButton] style:UIBarButtonItemStyleDone target:self action:@selector(actionButtonPressed:)];
    self.navigationItem.rightBarButtonItem = self.setterButton;
}

- (void)viewWillLayoutSubviews
{
    CGSize constrainSize = CGSizeMake(self.scrollView.bounds.size.width, CGFLOAT_MAX);
    CGSize fieldEditorSize = [self.fieldEditorView sizeThatFits:constrainSize];
    self.fieldEditorView.frame = CGRectMake(0, 0, fieldEditorSize.width, fieldEditorSize.height);
    self.scrollView.contentSize = fieldEditorSize;
}

- (FLEXArgumentInputView *)firstInputView
{
    return [[self.fieldEditorView argumentInputViews] firstObject];
}

- (void)actionButtonPressed:(id)sender
{
    // Subclasses can override
    [self.fieldEditorView endEditing:YES];
}

- (NSString *)titleForActionButton
{
    // Subclasses can override.
    return @"Set";
}

@end
