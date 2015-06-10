//
//  ALPHARequest.h
//  Alpha
//
//  Created by Dal Rupnik on 09/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHASerializableItem.h"

extern NSString *const ALPHAFileRequestIdentifier;
extern NSString *const ALPHAFileURLParameterKey;
extern NSString *const ALPHAFileClassParameterKey;

/*!
 *  Data request wraps a special data request that data collectors can respond to.
 *  This is considered immutable object, although we allow changing of the properties.
 */
@interface ALPHARequest : NSObject <ALPHASerializableItem, NSCopying>

/*!
 *  Data identifier usually points to a specific group of data
 */
@property (nonatomic, copy) NSString *identifier;

/*!
 *  Detail parameters for specific group of data, such as ID, path, or similar data.
 *  To support serialization, parameters must be a property list
 */
@property (nonatomic, copy) NSDictionary *parameters;

#pragma mark - Convenience

+ (instancetype)requestWithIdentifier:(NSString *)identifier;
+ (instancetype)requestWithIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters;

#pragma mark - File requests

/*!
 *  Creates request for file with URL. Identifier used for file is 
 *
 *  @param fileURL file url is stored in parameters
 *
 *  @return request instance
 */
+ (instancetype)requestForFile:(NSString *)fileURL;
+ (instancetype)requestForFile:(NSString *)fileURL fileClass:(NSString *)fileClass;

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters;

@end
