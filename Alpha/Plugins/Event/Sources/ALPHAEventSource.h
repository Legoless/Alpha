//
//  ALPHAEventSource.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationEvent.h"

#import "ALPHABaseDataSource.h"

extern NSString *const ALPHAEventDataIdentifier;

@interface ALPHAEventSource : ALPHABaseDataSource

+ (instancetype)sharedSource;

/*!
 *  Adds new event
 *
 *  @param event model
 */
- (void)addEvent:(ALPHAApplicationEvent *)event;

@end
