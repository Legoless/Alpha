//
//  ALPHALocalSource.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHABaseSource.h"

@interface ALPHALocalSource : ALPHABaseSource

/*!
 *  Source collectors that provide data to the source
 */
@property (nonatomic, copy) NSArray *collectors;

@end
