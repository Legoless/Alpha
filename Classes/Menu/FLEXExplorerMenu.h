//
//  FLEXExplorerMenu.h
//  UICatalog
//
//  Created by Dal Rupnik on 21/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@class FLEXExplorerMenu;

@protocol FLEXExplorerMenuDelegate <NSObject>

@optional

- (void)explorerMenu:(FLEXExplorerMenu *)explorerMenu didSelectImage:(UIImage *)image;

@end

@interface FLEXExplorerMenu : UIView

/**
 *  If set to YES, menu will snap to border, similar to accessiblity menu
 *  of iOS. Default: NO
 */
@property (nonatomic) BOOL snapToBorder;

@property (nonatomic, copy) NSArray* images;
@property (nonatomic, weak) id<FLEXExplorerMenuDelegate> delegate;

@end
