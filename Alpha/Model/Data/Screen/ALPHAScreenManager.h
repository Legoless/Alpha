//
//  ALPHAScreenManager.h
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
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

@property (nonatomic, strong) id<ALPHASerializer> serializer;
@property (nonatomic, strong) id<ALPHADataConverterSource> converter;
@property (nonatomic, strong) ALPHAManager *manager;
@property (nonatomic, strong) ALPHATheme * theme;

+ (instancetype)defaultManager;

#pragma mark - Rendering methods

- (void)pushObject:(id)object;

- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer didSelectItem:(id)item;

@end
