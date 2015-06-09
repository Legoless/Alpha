//
//  ALPHADataSource.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHAIdentifiableItem.h"
#import "ALPHARequest.h"

typedef void (^ALPHADataSourceCompletion)(id model, NSError *error);

@protocol ALPHADataSource <NSObject>

/*!
 *  Returns YES if data source can complete dataWithRequest:completion: call. This call is done synchronously and only checks
 *  if data is available. Before calling dataWithRequest:completion: be sure to call this to check if source even has the
 *  data you are looking for. The call is really fast and can be done on any thread.
 *
 *  @param request data request
 *
 *  @return YES if data for request is available
 */
- (BOOL)hasDataForRequest:(ALPHARequest *)request;

/*!
 *  Request data with request object
 *
 *  @param request     data request object
 *  @param completion  called upon completion
 */
- (void)dataForRequest:(ALPHARequest *)request completion:(ALPHADataSourceCompletion)completion;

@optional

/*!
 *  Returns YES if data source can complete performAction:completion: call. This call is done synchronously and only checks
 *  if action can be performed. It does not modify any state. Always call this before calling performAction:completion: or
 *  the return callback of the call will be unknown
 *
 *  @param action to perform
 *
 *  @return YES if action can be performed
 */
- (BOOL)canPerformAction:(id<ALPHAIdentifiableItem>)action;

/*!
 *  Performs actions with identifiers
 *
 *  @param identifiers to be performed
 *  @param completion  called upon completion
 */
- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceCompletion)completion;

/*!
 *  Enable or disable source (can be optional)
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

@end
