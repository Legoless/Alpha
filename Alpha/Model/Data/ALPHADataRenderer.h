//
//  ALPHADataRenderer.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"

@protocol ALPHADataRenderer <NSObject>

/*!
 *  Current identifier to load, if data not available
 */
@property (nonatomic, copy) NSString *dataIdentifier;

/*!
 *  Data source, where data model is requested from
 */
@property (nonatomic, strong) id<ALPHADataSource> source;

/*!
 *  Data model if available
 */
@property (nonatomic, strong) id<ALPHASerializableItem> data;

@end
