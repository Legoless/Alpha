//
//  ALPHAObjectModel.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAModel.h"

@interface ALPHAObjectModel : ALPHAModel

/*!
 *  Class name of object that is described with object model
 */
@property (nonatomic, copy) NSString *objectClass;

/*!
 *  Stores object description
 */
@property (nonatomic, copy) NSString *objectDescription;

//
// Object model
//
@property (nonatomic, copy) NSArray *properties;

@property (nonatomic, copy) NSArray *ivars;

@property (nonatomic, copy) NSArray *methods;

@property (nonatomic, copy) NSArray *classMethods;

@property (nonatomic, copy) NSArray *superclasses;

@end
