//
//  ALPHALocalSource.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataSource.h"

/*!
 *  Local data source, looks into locally installed plugins for data sources and delegates
 *  requests to sources in enabled plugins.
 *
 *  Final class, should not be subclassed.
 */
@interface ALPHALocalSource : NSObject <ALPHADataSource>

/*!
 *  Source collectors that provide data to the source
 */
@property (nonatomic, copy) NSArray *sources;

- (void)loadSourcesFromPlugins:(NSArray *)plugins;

@end
