//
//  ALPHADataSource.h
//  UICatalog
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataModel.h"

typedef void (^ALPHADataSourceCompletion)(ALPHADataModel *dataModel, NSError *error);

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
- (void)performActionsWithIdentifiers:(NSArray *)identifiers completion:(ALPHADataSourceCompletion)completion;

@optional

/*!
 *  Request refresh data with specific identifier
 *
 *  @param identifier data identifier (model, section or item)
 *  @param completion called upon completion
 */
- (void)refreshWithIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;

- (void)performActionWithIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;

@end
