//
//  ALPHAExplorerMenu.h
//  Alpha
//
//  Created by Dal Rupnik on 21/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

@class ALPHAExplorerMenu;

@protocol ALPHAExplorerMenuDelegate <NSObject>

@optional

- (void)explorerMenu:(ALPHAExplorerMenu *)explorerMenu didSelectImage:(UIImage *)image;

@end

@interface ALPHAExplorerMenu : UIView

/*!
 *  If set to YES, menu will snap to border, similar to accessiblity menu
 *  of iOS. Default: NO
 */
@property (nonatomic) BOOL snapToBorder;

@property (nonatomic, copy) NSArray* images;
@property (nonatomic, weak) id<ALPHAExplorerMenuDelegate> delegate;

@end
