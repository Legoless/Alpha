//
//  ALPHAEventCollector.h
//  Alpha
//
//  Created by Dal Rupnik on 08/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationEvent.h"

#import "ALPHADataCollector.h"

extern NSString *const ALPHAEventDataIdentifier;

@interface ALPHAEventCollector : ALPHADataCollector

+ (instancetype)sharedCollector;

/*!
 *  Adds new event
 *
 *  @param event model
 */
- (void)addEvent:(ALPHAApplicationEvent *)event;

@end
