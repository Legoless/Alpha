//
//  ALPHAScreenManager.h
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataRenderer.h"
#import "ALPHASerialization.h"
#import "ALPHAConversion.h"
#import "ALPHAManager.h"

/*!
 *  Encapsulated common rendering code such as connecting between screens based on actions.
 */
@interface ALPHAScreenManager : NSObject

#pragma mark - Properties for rendering

@property (nonatomic, strong) id<ALPHADataConverterSource> converter;
@property (nonatomic, strong) ALPHAManager *manager;

@property (nonatomic, readonly) ALPHATheme *theme;

+ (instancetype)defaultManager;

#pragma mark - Rendering methods

- (void)pushObject:(id)object;

- (void)pushViewController:(UIViewController *)viewController;

- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer didSelectItem:(id)item;

@end
