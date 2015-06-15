//
//  ALPHAObjectProperty.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"

#import "ALPHAObjectReference.h"

#import "ALPHAObjectPrintable.h"

@protocol ALPHAObjectProperty <NSObject>

@end

@interface ALPHAObjectProperty : ALPHAObjectReference <ALPHAObjectPrintable>

//
// Property info
//

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) ALPHAObjectType* type;

@property (nonatomic, copy) NSString *value;

/*!
 *  Attributes from runtime inspection
 */
@property (nonatomic, copy) NSDictionary *attributes;

#pragma mark - Convenience

- (BOOL)isReadOnly;
- (BOOL)isDynamic;

- (NSString *)setter;
- (NSString *)getter;

@end
