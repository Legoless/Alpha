//
//  ALPHARendererManager.h
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHADataRenderer.h"
#import "ALPHASerialization.h"
#import "ALPHAConversion.h"

/*!
 *  Encapsulated common rendering code such as connecting between screens based on actions.
 */
@interface ALPHARendererManager : NSObject

@property (nonatomic, strong) id<ALPHASerializer> serializer;
@property (nonatomic, strong) id<ALPHADataConverterSource> converter;

+ (instancetype)sharedManager;

- (void)renderer:(UIViewController<ALPHADataRenderer> *)renderer didSelectItem:(ALPHAScreenItem *)item;

@end
