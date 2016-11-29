//
//  NSObject+NSObject_Swizzle.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
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
+ (void)alpha_swizzleInstanceMethod:(SEL)firstMethod withMethod:(SEL)secondMethod;

/*!
 * Method changes the implementation of the first class method to second method.
 * This method must be called inside class's load method.
 *
 * @param firstMethod first method
 * @param secondMethod second method
 */
+ (void)alpha_swizzleClassMethod:(SEL)firstMethod withMethod:(SEL)secondMethod;

/*!
 * Method changes the implementation of the first class method to second method.
 * This method must be called inside class's load method.
 *
 * @param firstMethod first method
 * @param secondMethod second method
 * @param class to change method implementation
 */
+ (void)alpha_swizzleInstanceMethod:(SEL)firstMethod withMethod:(SEL)secondMethod inClass:(Class)class;

+ (void)alpha_swizzleClassMethod:(SEL)firstMethod withMethod:(SEL)secondMethod inClass:(Class)class;

@end
