//
//  ALPHAFieldRendererViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 12/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"
#import "ALPHAObjectModel.h"

#import "ALPHADataRenderer.h"

@class ALPHAFieldEditorView;
@class ALPHAArgumentInputView;

@interface ALPHAFieldRendererViewController : UIViewController <ALPHADataRenderer>

#pragma mark - ALPHADataRenderer

/*!
 *  Screen model is ignored in this case
 */
@property (nonatomic, strong) ALPHAScreenModel* screenModel;

/*!
 *  Data model if available
 */
@property (nonatomic, strong) id<ALPHASerializableItem> object;

/*!
 *  Data source, where data model is requested from
 */
@property (nonatomic, strong) id<ALPHADataSource> source;

/*!
 *  Theme reference for data renderer
 */
@property (nonatomic, strong) ALPHATheme *theme;

/*!
 *  Refreshes the data rendered screen, by sending request to source
 */
- (void)refresh;

#pragma mark - Field Editor

// Convenience accessor since many subclasses only use one input view
@property (nonatomic, readonly) ALPHAArgumentInputView *firstInputView;

//
// For subclass use only.
//
@property (nonatomic, strong, readonly) ALPHAFieldEditorView *fieldEditorView;
@property (nonatomic, strong, readonly) UIBarButtonItem *setterButton;

- (void)actionButtonPressed:(id)sender;
- (NSString *)titleForActionButton;

- (void)updateView;

@end
