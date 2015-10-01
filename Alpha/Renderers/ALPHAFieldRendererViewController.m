//
//  ALPHAFieldRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFieldRendererViewController.h"
#import "ALPHAFieldEditorView.h"
#import "ALPHARuntimeUtility.h"
#import "ALPHAUtility.h"
#import "ALPHAArgumentInputView.h"
#import "ALPHAArgumentInputViewFactory.h"

@interface ALPHAFieldRendererViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong, readwrite) ALPHAFieldEditorView *fieldEditorView;
@property (nonatomic, strong, readwrite) UIBarButtonItem *setterButton;

@end

@implementation ALPHAFieldRendererViewController

#pragma mark - Getters and Setters

- (void)setObject:(id<ALPHASerializableItem>)object
{
    _object = object;
    
    if (self.isViewLoaded)
    {
        [self updateView];
    }
}

- (NSString *)titleForActionButton
{
    // Subclasses can override.
    return @"Set";
}

- (ALPHAArgumentInputView *)firstInputView
{
    return [[self.fieldEditorView argumentInputViews] firstObject];
}

#pragma mark - Initialization

- (instancetype)initWithObject:(id)object
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = self.theme.backgroundColor;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = self.theme.backgroundColor;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.fieldEditorView = [[ALPHAFieldEditorView alloc] init];
    self.fieldEditorView.backgroundColor = self.theme.backgroundColor;
    self.fieldEditorView.separatorColor = self.theme.fieldSeparatorColor;
    if (self.theme.fieldTintColor) {
        self.fieldEditorView.tintColor = self.theme.fieldTintColor;
    }else {
        self.fieldEditorView.tintColor = self.theme.cellTitleColor;
    }
    
    [self.scrollView addSubview:self.fieldEditorView];
    
    self.setterButton = [[UIBarButtonItem alloc] initWithTitle:[self titleForActionButton] style:UIBarButtonItemStyleDone target:self action:@selector(actionButtonPressed:)];
    self.navigationItem.rightBarButtonItem = self.setterButton;
    
    if (self.object)
    {
        [self updateView];
    }
}

- (void)viewWillLayoutSubviews
{
    CGSize constrainSize = CGSizeMake(self.scrollView.bounds.size.width, CGFLOAT_MAX);
    CGSize fieldEditorSize = [self.fieldEditorView sizeThatFits:constrainSize];
    self.fieldEditorView.frame = CGRectMake(0, 0, fieldEditorSize.width, fieldEditorSize.height);
    self.scrollView.contentSize = fieldEditorSize;
}

#pragma mark - Keyboard

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect keyboardRectInWindow = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize keyboardSize = [self.view convertRect:keyboardRectInWindow fromView:nil].size;
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = keyboardSize.height;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
    
    // Find the active input view and scroll to make sure it's visible.
    for (ALPHAArgumentInputView *argumentInputView in self.fieldEditorView.argumentInputViews)
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

#pragma mark - Actions

- (void)actionButtonPressed:(id)sender
{
    // Subclasses can override
    [self.fieldEditorView endEditing:YES];
}

#pragma mark - Private methods

- (void)updateView
{
    if ([self.object isKindOfClass:[ALPHAObjectElement class]])
    {
        ALPHAObjectElement *reference = self.object;
        
        self.fieldEditorView.targetDescription = [NSString stringWithFormat:@"%@ %@", reference.objectClass, reference.objectPointer];
    }
    else
    {
        self.fieldEditorView.targetDescription = [NSString stringWithFormat:@"%@ %p", [self.object class], self.object];
    }
    
}

- (void)refresh
{
    
}

@end
