//
//  ALPHAObjectArgument.h
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerialization.h"
#import "ALPHAObjectPrintable.h"

@protocol ALPHAObjectType <NSObject>

@end

@interface ALPHAObjectType : NSObject <ALPHASerializableItem, ALPHAObjectPrintable>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cType;

/*!
 *  Cleans name so clean string is returned (pointer stars removed)
 *
 *  @return type string
 */
- (NSString *)typeString;

@end
