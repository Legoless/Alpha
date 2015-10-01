//
//  ALPHATableScreenModel.h
//  Alpha
//
//  Created by Dal Rupnik on 05/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenModel.h"
#import "ALPHAScreenSection.h"

@interface ALPHATableScreenModel : ALPHAScreenModel

/*!
 *  Set table view style, default is plain
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/*!
 *  Default row height on table view
 */
@property (nonatomic, assign) CGFloat rowHeight;

/*!
 *  Set table view separator style
 */
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle;

/*!
 *  Array of display section objects objects
 */
@property (nonatomic, copy) NSArray *sections;

@end
