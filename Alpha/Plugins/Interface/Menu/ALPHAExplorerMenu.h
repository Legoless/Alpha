//
//  ALPHAExplorerMenu.h
//  Alpha
//
//  Created by Dal Rupnik on 21/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@class ALPHAExplorerMenu;

@protocol ALPHAExplorerMenuDelegate <NSObject>

@optional

- (void)explorerMenu:(ALPHAExplorerMenu *)explorerMenu didSelectImage:(UIImage *)image;

@end

/*!
 *  Main Alpha Menu
 */
@interface ALPHAExplorerMenu : UIView

@property (nonatomic, strong) UIColor *mainBackgroundColor;

@property (nonatomic, strong) UIColor *buttonBackgroundColor;
@property (nonatomic, strong) UIColor *buttonSelectedBackgroundColor;

/*!
 *  If set to YES, menu will snap to border, similar to accessiblity menu
 *  of iOS. Default: NO
 */
@property (nonatomic) BOOL snapToBorder;

/*!
 *  When no action is set, this image is displayed
 */
@property (nonatomic, strong) UIImage *mainImage;

@property (nonatomic, copy) NSArray* images;
@property (nonatomic, weak) id<ALPHAExplorerMenuDelegate> delegate;

@end
