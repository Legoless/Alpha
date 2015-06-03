//
//  ALPHAConverterManager.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataConverterSource.h"

/*!
 *  Object can convert Alpha Data Model to Screen Model that can be convertred using one of
 *  the child data converter sources.
 */
@interface ALPHAConverterManager : NSObject <ALPHADataConverterSource>

@property (nonatomic, readonly) NSArray *converterSources;

+ (instancetype)sharedManager;

- (void)registerConverterSource:(id<ALPHADataConverterSource>)converterSource;

#pragma mark - ALPHADataConverterSource

- (BOOL)canConvertModel:(ALPHAModel *)model;

- (ALPHAScreenModel *)screenModelForModel:(ALPHAModel *)model;

@end
