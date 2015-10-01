//
//  ALPHAObjectContent.h
//  Alpha
//
//  Created by Dal Rupnik on 12/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

#import "ALPHAObjectElement.h"

/*!
 *  Carries pointers to internal objects in case of arrays or sets
 */
@interface ALPHAObjectContent : NSObject <ALPHASerializableItem,NSCopying>

@property (nonatomic, copy) NSArray<ALPHAObjectElement> *items;

+ (instancetype)objectContentForArray:(NSArray *)array;
+ (instancetype)objectContentForDictionary:(NSDictionary *)dictionary;
+ (instancetype)objectContentForSet:(NSSet *)set;
+ (instancetype)objectContentForOrderedSet:(NSOrderedSet *)orderedSet;
+ (instancetype)objectContentForUserDefaults:(NSUserDefaults *)defaults;

@end
