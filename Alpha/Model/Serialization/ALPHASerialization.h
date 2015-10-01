//
//  ALPHASerialization.h
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#import "ALPHASerializableItem.h"

@interface NSObject (Serialization) <NSSecureCoding>

//coding

+ (NSDictionary *)codableProperties;
- (void)setWithCoder:(NSCoder *)aDecoder;

//property access

- (NSDictionary *)codableProperties;
- (NSDictionary *)dictionaryRepresentation;

@end