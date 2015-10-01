//
//  ALPHAConverterManager.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataConverterSource.h"

/*!
 *  Object can convert Alpha Data Model to Screen Model that can be converted using one of
 *  the child data converter sources.
 */
@interface ALPHAConverterManager : NSObject <ALPHADataConverterSource>

@property (nonatomic, readonly) NSArray *converterSources;

+ (instancetype)sharedManager;

- (void)registerConverterSource:(id<ALPHADataConverterSource>)converterSource;

@end
