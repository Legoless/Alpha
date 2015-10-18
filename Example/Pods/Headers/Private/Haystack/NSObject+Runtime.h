//
//  NSObject+Runtime.h
//

@import Foundation;

@interface NSObject (Runtime)

+ (NSArray *)hay_subclasses;

- (NSArray *)hay_subclasses;

/**
 *  Returns array of Class that are hay_subclasses of class
 *
 *  @param parent subclasses
 *
 *  @return array of Class objects
 */
+ (NSArray *)hay_subclassesOfClass:(Class)parentClass;

@end
