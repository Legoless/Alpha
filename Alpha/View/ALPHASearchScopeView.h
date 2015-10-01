//
//  ALPHASearchScopeView.h
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

/*!
 *  Wraps UISearchBar and UISegmentedControl for full customization, uses same API as UISearchBar
 */
@interface ALPHASearchScopeView : UIView

@property (nonatomic, weak) id<UISearchBarDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedScopeButtonIndex;
@property (nonatomic, copy) NSArray *scopeButtonTitles;

@property (nonatomic, assign) BOOL showsSearchBar;
@property (nonatomic, assign) BOOL showsScopeBar;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UIFont *font;

//
// Exposed for customization
//
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end
