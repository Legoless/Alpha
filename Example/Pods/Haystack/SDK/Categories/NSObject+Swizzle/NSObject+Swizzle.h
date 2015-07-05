//
//  NSObject+Swizzle.h
//

@import Foundation;

@interface NSObject (Swizzle)

/*!
 * Method changes the implementation of the first instance method to second method. 
 * This method must be called inside class's load method.
 *
 * @param firstMethod first method
 * @param secondMethod second method
 */
+ (void)hay_swizzleInstanceMethod:(SEL)firstMethod withMethod:(SEL)secondMethod;

/*!
 * Method changes the implementation of the first class method to second method.
 * This method must be called inside class's load method.
 *
 * @param firstMethod first method
 * @param secondMethod second method
 */
+ (void)hay_swizzleClassMethod:(SEL)firstMethod withMethod:(SEL)secondMethod;

+ (void)hay_swizzleInstanceMethod:(SEL)firstMethod withMethod:(SEL)secondMethod inClass:(Class)class;

+ (void)hay_swizzleClassMethod:(SEL)firstMethod withMethod:(SEL)secondMethod inClass:(Class)class;

@end
