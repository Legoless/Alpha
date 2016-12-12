//
//  ALPHADataConverterSource.h
//  Alpha
//
//  Created by Dal Rupnik on 02/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"
#import "ALPHAScreenModel.h"

/*!
 *  Data Converter source takes Alpha model and converts it to screen model
 */
@protocol ALPHADataConverterSource <NSObject>

/*!
 *  Each source is asked if object can be converted, no other calls are made if this call returns NO, to save
 *  the resources required to convert some objects.
 *
 *  @param object of data
 *
 *  @return YES if conversion is possible
 */
- (BOOL)canConvertObject:(id)object;

/*!
 *  Method converts data model into screen model to be rendered
 *
 *  @param object of data
 *
 *  @return screen model if successful, nil otherwise
 */
- (ALPHAScreenModel *)screenModelForObject:(id)object;

@optional

/*!
 *  Returns renderer class for an object. If class is returned, object will be rendered using that class.
 *
 *  @param object to be rendered
 *
 *  @return class that can render the object
 */
- (Class)renderClassForObject:(id)object;

@end
