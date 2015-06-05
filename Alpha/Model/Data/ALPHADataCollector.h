//
//  ALPHADataCollector.h
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"
#import "ALPHAActionItem.h"

@interface ALPHADataCollector : NSObject

/*!
 *  Enable or disable specific collector
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

#pragma mark - Data

/*!
 *  Returns data for identifier in async way
 *
 *  @param identifier of data
 *  @param completion called upon completion
 */
- (void)collectDataForIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;

/*!
 *  Returns yes, if data collectors has data for specific identifier
 *
 *  @param identifier of data
 */
- (BOOL)hasDataForIdentifier:(NSString *)identifier;

#pragma mark - Action

- (BOOL)canPerformAction:(ALPHAActionItem *)action;

- (BOOL)canPerformActionForIdentifier:(NSString *)identifier;

- (void)performAction:(ALPHAActionItem *)action completion:(ALPHADataSourceCompletion)completion;

- (void)performActionWithIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;

#pragma mark - Subclass

//
// The methods below should not be used outside of subclasses and provide convenience methods
// for subclasses.
//

/*!
 *  Adds data identifier so the collectors gets collect data calls
 *
 *  @param identifier of data
 */
- (void)addDataIdentifier:(NSString *)identifier;

/*!
 *  Adds action identifier so the sources can execute actions
 *
 *  @param identifier of action
 */
- (void)addActionIdentifier:(NSString *)identifier;

#pragma mark - Subclass override

//
// The following methods should be overriden by subclasses to provide correct values
//

/*!
 *  Returns new instance of data model (to be overriden)
 *
 *  @return new instance
 */
- (ALPHAModel *)model;

@end
