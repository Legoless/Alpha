//
//  ALPHADataCollector.h
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"

@interface ALPHADataCollector : NSObject

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
- (void)collectDataForIdentifier:(NSString *)identifier completion:(ALPHADataSourceCompletion)completion;

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
 *  Returns new instance of data model (to be overriden)
 *
 *  @return new instance
 */
- (ALPHAModel *)model;

@end
