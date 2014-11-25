//
//  FLEXMenuItem.h
//  UICatalog
//
//  Created by Dal Rupnik on 25/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXActionItem.h"

@interface FLEXMenuItem : FLEXActionItem

/*!
 *  Action that opens a view controller should have this property set.
 */
@property (nonatomic, strong) NSString* viewControllerClass;

@end
