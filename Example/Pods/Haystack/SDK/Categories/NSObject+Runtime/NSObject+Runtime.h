//
//  NSObject+Runtime.h
//

@import Foundation;

@interface NSObject (Runtime)

+ (NSArray *)subclasses;

- (NSArray *)subclasses;

/**
 *  Returns array of Class that are subclasses of class
 *
 *  @param parent subclasses
 *
 *  @return array of Class objects
 */
+ (NSArray *)subclassesOfClass:(Class)parentClass;

@end
