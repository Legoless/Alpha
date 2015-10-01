//
//  ALPHAExplorerToolbar.h
//  Alpha
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import UIKit;

@class ALPHAToolbarItem;

@interface ALPHAExplorerToolbar : UIView

/// Toolbar item for selecting views.
/// Users of the toolbar can configure the enabled/selected state and event targets/actions.
@property (nonatomic, strong, readonly) ALPHAToolbarItem *selectItem;

/// Toolbar item for presenting a list with the view hierarchy.
/// Users of the toolbar can configure the enabled state and event targets/actions.
@property (nonatomic, strong, readonly) ALPHAToolbarItem *hierarchyItem;

/// Toolbar item for moving views.
/// Users of the toolbar can configure the enabled/selected state and event targets/actions.
@property (nonatomic, strong, readonly) ALPHAToolbarItem *moveItem;

/// Toolbar item for inspecting details of the selected view.
/// Users of the toolbar can configure the enabled state and event targets/actions.
@property (nonatomic, strong, readonly) ALPHAToolbarItem *globalsItem;

/// Toolbar item for hiding the explorer.
/// Users of the toolbar can configure the event targets/actions.
@property (nonatomic, strong, readonly) ALPHAToolbarItem *closeItem;

/// A view for moving the entire toolbar.
/// Users of the toolbar can attach a pan gesture recognizer to decide how to reposition the toolbar.
@property (nonatomic, strong, readonly) UIView *dragHandle;

/// A color matching the overlay on color on the selected view.
@property (nonatomic, strong) UIColor *selectedViewOverlayColor;

/// Description text for the selected view displayed below the toolbar items.
@property (nonatomic, copy) NSString *selectedViewDescription;

/// Area where details of the selected view are shown
/// Users of the toolbar can attach a tap gesture recognizer to show additional details.
@property (nonatomic, strong, readonly) UIView *selectedViewDescriptionContainer;

@end
