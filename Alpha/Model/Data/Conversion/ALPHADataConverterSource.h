//
//  ALPHADataConverterSource.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"

/*!
 *  Data Converter source takes Alpha model and converts it to screen model
 */
@protocol ALPHADataConverterSource <NSObject>

/*!
 *  Each source is asked if model can be converted
 *
 *  @param model of data
 *
 *  @return YES if conversion is possible
 */
- (BOOL)canConvertModel:(ALPHAModel *)model;

/*!
 *  Method converts data model into screen model to be rendered
 *
 *  @param model of data
 *
 *  @return screen model if successful, nil otherwise
 */
- (ALPHAScreenModel *)screenModelForModel:(ALPHAModel *)model;

@end
