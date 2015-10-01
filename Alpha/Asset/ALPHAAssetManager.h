//
//  ALPHAAssetManager.h
//  Alpha
//
//  Created by Dal Rupnik on 17/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "UIImage+Creation.h"
#import "ALPHAAsset.h"

/*!
 *  Works with assets, loads all registered subclasses of ALPHAAsset on start
 */
@interface ALPHAAssetManager : NSObject

/*!
 *  Singleton access to Alpha Manager, main entry point
 *
 *  @return shared instance of the manager
 */
+ (instancetype)sharedManager;

/*!
 *  Dynamically adds new asset to existing asset manager
 *
 *  @param asset to add
 */
- (void)registerAsset:(ALPHAAsset *)asset;

#pragma mark - Image creation methods

- (UIImage *)imageWithAsset:(ALPHAAsset *)asset;
- (UIImage *)imageWithAsset:(ALPHAAsset *)asset color:(UIColor *)color;
- (UIImage *)imageWithAsset:(ALPHAAsset *)asset color:(UIColor *)color size:(CGSize)size;

- (UIImage *)imageWithIdentifier:(NSString *)identifier;
- (UIImage *)imageWithIdentifier:(NSString *)identifier color:(UIColor *)color;
- (UIImage *)imageWithIdentifier:(NSString *)identifier color:(UIColor *)color size:(CGSize)size;

@end
