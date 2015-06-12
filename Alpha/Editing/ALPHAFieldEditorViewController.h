//
//  ALPHAFieldEditorViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"
#import "ALPHAObjectModel.h"

@class FLEXFieldEditorView;
@class FLEXArgumentInputView;

@interface ALPHAFieldEditorViewController : UIViewController

- (id)initWithSource:(id<ALPHADataSource>)source objectTarget:(ALPHAObjectModel *)target;

// Convenience accessor since many subclasses only use one input view
@property (nonatomic, readonly) FLEXArgumentInputView *firstInputView;

// For subclass use only.
@property (nonatomic, strong, readonly) ALPHAObjectModel *target;
@property (nonatomic, strong, readonly) id<ALPHADataSource> source;
@property (nonatomic, strong, readonly) FLEXFieldEditorView *fieldEditorView;
@property (nonatomic, strong, readonly) UIBarButtonItem *setterButton;
- (void)actionButtonPressed:(id)sender;
- (NSString *)titleForActionButton;

@end
