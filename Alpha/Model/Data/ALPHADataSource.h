//
//  ALPHADataSource.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHAIdentifiableItem.h"

typedef void (^ALPHADataSourceCompletion)(id model, NSError *error);

@protocol ALPHADataSource <NSObject>

/*!
 *  Request new data with multiple identifiers
 *
 *  @param identifiers data identifier (model, section or item)
 *  @param completion  called upon completion
 */
- (void)refreshWithIdentifiers:(NSArray *)identifiers completion:(ALPHADataSourceCompletion)completion;

/*!
 *  Performs actions with identifiers
 *
 *  @param identifiers to be performed
 *  @param completion  called upon completion
 */
- (void)performAction:(id<ALPHAIdentifiableItem>)action completion:(ALPHADataSourceCompletion)completion;

/*!
 *  Retrieves file with URL (to transfer files)
 *
 *  @param url        url
 *  @param completion called upon completion
 */
- (void)fileWithURL:(NSURL *)url completion:(ALPHADataSourceCompletion)completion;

@optional

/*!
 *  Request refresh data with specific identifier
 *
 *  @param identifier data identifier (model, section or item)
 *  @param completion called upon completion
 */
- (void)refreshWithIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;

@end
