//
//  NSObject+ALPHASerialization.h
//  Alpha
//
//  Created by Dal Rupnik on 03/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Idea taken from NSObject-ObjectMap, but certain helper methods are moved to a separate class,
 *  not to pollute NSObject category.
 */
@interface NSObject (ALPHASerialization)

+ (NSArray *)arrayOfObjectsWithDictionaries:(NSArray *)dictionaries;
+ (NSArray *)arrayOfObjectsWithDictionaries:(NSArray *)dictionaries error:(NSError **)error;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary error:(NSError **)error;

- (NSDictionary *)toDictionary;

@end

@interface NSObject (ALPHAJSONSerialization)

- (instancetype)initWithJSONData:(NSData *)data;
- (instancetype)initWithJSONData:(NSData *)data error:(NSError **)error;

- (instancetype)initWithJSONString:(NSString *)JSONString;
- (instancetype)initWithJSONString:(NSString *)JSONString error:(NSError **)error;

- (NSString *)toJSONString;

- (NSData *)toJSONData;

@end
