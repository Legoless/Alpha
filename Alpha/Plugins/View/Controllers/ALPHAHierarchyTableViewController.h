//
//  ALPHAHierarchyTableViewController.h
//  Alpha
//
//  Created by Dal Rupnik on 16/6/2015.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHATableRendererViewController.h"

@interface ALPHAHierarchyTableViewController : ALPHATableRendererViewController

@property (nonatomic, strong) UIView* selectedView;

- (id)initWithViews:(NSArray *)allViews viewsAtTap:(NSArray *)viewsAtTap selectedView:(UIView *)selectedView depths:(NSDictionary *)depthsForViews;

@end
