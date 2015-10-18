//
//  NSObject+Property.h
//

@import Foundation;

@interface NSObject (Property)

/*!
 *  Returns key value pair of property strings, where the key is property hay_name,
 *  and value is the type of key.
 *
 *  @return dictionary of key-value mapped object properties
 */
- (NSDictionary *)hay_properties;

+ (NSDictionary *)hay_properties;

@end
