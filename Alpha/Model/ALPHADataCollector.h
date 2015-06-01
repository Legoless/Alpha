//
//  ALPHADataCollector.h
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHADataModel.h"

@interface ALPHADataCollector : NSObject

/*!
 *  Returns root data that was collected last
 */
@property (nonatomic, readonly) ALPHADataModel *latestRootData;

/*!
 *  Enable or disable specific collector
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Returns data for identifier in async way
 *
 *  @param identifier of data
 *  @param completion called upon completion
 */
- (void)collectDataForIdentifier:(NSString *)identifier completion:(void (^)(ALPHADataModel *model, NSError *error))completion;

/*!
 *  Returns yes, if data collectors has data for specific identifier
 *
 *  @param identifier of data
 */
- (BOOL)hasDataForIdentifier:(NSString *)identifier;

#pragma mark - Subclass

//
// The methods below should not be used outside of subclasses and provide convenience methods
// for subclasses.
//
- (void)addDataIdentifier:(NSString *)identifier;

/*!
 *  Returns root data model
 *
 *  @return new instance
 */
//- (ALPHADataModel *)collectRootData;

@end
