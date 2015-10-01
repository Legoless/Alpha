//
//  ALPHABaseDataSource.h
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"
#import "ALPHAIdentifiableItem.h"

/*!
 *  Base data collector implementation. The main goal of this object is to provide model data.
 *  This is a local implementation and knows how to execute basic actions (block and selector only).
 *  Data checks are done against identifiers by default, override the methods if specific functionality
 *  is needed.
 *
 *  When dataForRequest:completion: method is called, the default implementation calls synchronously 
 *  the method: modelForRequest and provides request as the parameter. If that method is not subclassed,
 *  the result is nil.
 *
 *  All methods take @enabled property into consideration and will return NO when disabled.
 */
@interface ALPHABaseDataSource : NSObject <ALPHADataSource>

/*!
 *  Enable or disable collector.
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

#pragma mark - Subclass convienience

//
// The methods below should not be used outside of subclasses and provide convenience methods
// for subclasses. Under no condition should you call these methods outside data collection.
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
 *  Returns new instance of data model (to be overriden) for request
 *
 *  @return new instance
 */
- (ALPHAModel *)modelForRequest:(ALPHARequest *)request;

@end
