//
//  KZBootstrap+FLEXUtilities.h
//  UICatalog
//
//  Created by Dal Rupnik on 10/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "KZBootstrap.h"

@interface KZBootstrap (FLEXUtilities)

/**
 *  Returns YES if KZBootstrap environments are available.
 *
 *  @return YES if KZBEnvironments.plist is available
 */
+ (BOOL)isReady;

@end
