//
//  ALPHADataModel.h
//  Alpha
//
//  Created by Dal Rupnik on 29/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"
#import "ALPHAScreenSection.h"
#import "ALPHAScreenItem.h"
#import "ALPHAActionItem.h"
#import "ALPHAModel.h"

/*!
 *  Data Model wraps data displayed on a single screen
 */
@interface ALPHAScreenModel : ALPHAModel

/*!
 *  Specify expiration rate (default: 0 - no expiration) that model expires and 
 *  data source should be asked for new version.
 */
@property (nonatomic, assign) NSTimeInterval expiration;

/*!
 *  Title of data model which is usually displayed on top of navigation screen
 */
@property (nonatomic, copy) NSString *title;

/*!
 *  Action item that is usually displayed on top right of navigation bar
 */
@property (nonatomic, strong) ALPHAActionItem *leftAction;

/*!
 *  Action item that is usually displayed on top right of navigation bar
 */
@property (nonatomic, strong) ALPHAActionItem *rightAction;

#pragma mark - Search

/*!
 *  If search is available, set this property and data renderer will render a search and send
 *  search requests.
 */
@property (nonatomic, copy) NSString *searchBarPlaceholder;

/*!
 *  Scopes are displayed under search bar as segmented control that allows user to set specific filters
 */
@property (nonatomic, copy) NSArray *scopes;

@end
