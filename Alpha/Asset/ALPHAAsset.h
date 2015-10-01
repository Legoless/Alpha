//
//  ALPHAAsset.h
//  Alpha
//
//  Created by Dal Rupnik on 18/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "UIImage+Creation.h"

/*!
 *  Asset wraps code to render image, either a drawing block or image.
 *
 *  To automatically load asset, implement a subclass and override "init" setter.
 */
@interface ALPHAAsset : NSObject

/*!
 *  Id for asset, so it is properly cached.
 */
@property (nonatomic, copy) NSString *identifier;

/*!
 *  Assets can be created from drawing blocks that use Core Graphics to draw the image
 */
@property (nonatomic, copy) ALPHADrawingBlock drawingBlock;

/*!
 *  If drawing block is set, we need an original drawing size
 */
@property (nonatomic, assign) CGSize drawingSize;

/*!
 *  Asset can already be an image (backwards compatibility)
 */
@property (nonatomic, copy) UIImage *assetImage;

- (instancetype)initWithIdentifier:(NSString *)identifier;

#pragma mark - Creation methods

/*!
 *  Creates UIImage from asset data
 *
 *  @param color that image is tinted withj
 *
 *  @return new instance of image
 */
- (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
