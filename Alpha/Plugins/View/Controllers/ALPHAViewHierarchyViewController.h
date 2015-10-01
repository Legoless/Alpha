//
//  ALPHAViewHierarchyViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

#import "ALPHAViewController.h"

typedef NS_ENUM(NSUInteger, ALPHAExplorerMode) {
    ALPHAViewHierarchyModeDefault,
    ALPHAViewHierarchyModeSelect,
    ALPHAViewHierarchyModeMove
};

@interface ALPHAViewHierarchyViewController : ALPHAViewController

/// Tracks the currently active tool/mode
@property (nonatomic, assign) ALPHAExplorerMode currentMode;

@end
