//
//  ALPHAObjectProperty.h
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAObjectType.h"

#import "ALPHAObjectElement.h"

#import "ALPHAObjectPrintable.h"

@protocol ALPHAObjectProperty <NSObject>

@end

@interface ALPHAObjectProperty : ALPHAObjectElement <ALPHAObjectPrintable>

//
// Property info
//

@property (nonatomic, strong) ALPHAObjectType* type;

@property (nonatomic, strong) id value;

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
