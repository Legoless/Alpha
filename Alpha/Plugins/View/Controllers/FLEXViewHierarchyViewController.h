//
//  FLEXViewHierarchyViewController.h
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "ALPHAViewController.h"

typedef NS_ENUM(NSUInteger, FLEXExplorerMode) {
    FLEXViewHierarchyModeDefault,
    FLEXViewHierarchyModeSelect,
    FLEXViewHierarchyModeMove
};

@interface FLEXViewHierarchyViewController : ALPHAViewController

/// Tracks the currently active tool/mode
@property (nonatomic, assign) FLEXExplorerMode currentMode;

@end
