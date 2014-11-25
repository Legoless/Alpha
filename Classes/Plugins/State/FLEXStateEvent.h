//
//  FLEXStateEvent.h
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "JSONModel.h"

@interface FLEXStateEvent : JSONModel

@property (nonatomic, copy) NSString* name;

/*!
 *  Level priority
 */
@property (nonatomic) NSInteger level;

@end
