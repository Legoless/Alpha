//
//  ALPHATableScreenModel.h
//  Alpha
//
//  Created by Dal Rupnik on 05/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenModel.h"

@interface ALPHATableScreenModel : ALPHAScreenModel

/*!
 *  Set table view style, default is plain
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/*!
 *  Array of display section objects objects
 */
@property (nonatomic, copy) NSArray *sections;

@end
