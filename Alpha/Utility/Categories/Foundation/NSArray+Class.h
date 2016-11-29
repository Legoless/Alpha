//
//  NSArray+Class.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import Foundation;

@interface NSArray (Class)

/*!
 *  Returns first object instance that matches specified class
 *
 *  @param objectClass class object
 *
 *  @return first instance of class, or nil
 */
- (id)alpha_firstObjectOfClass:(Class)objectClass;

/*!
 *  Returns last object instance that matches specified class
 *
 *  @param objectClass class object
 *
 *  @return last instance of class, or nil
 */
- (id)alpha_lastObjectOfClass:(Class)objectClass;

/*!
 * Returns YES, if at least one object in array is member of provided class.
 *
 * @param objectClass class of object
 * @return YES if array contains an object of same class.
 */
- (BOOL)alpha_containsObjectOfClass:(Class)objectClass;

/*!
 * Returns YES, if at least one object in array is of provided class or
 * has inherited from provided class.
 *
 * @param objectClass class of object
 * @return YES if array contains an object of same or inherited class.
 */
- (BOOL)alpha_containsObjectOfInheritedClass:(Class)objectClass;

/*!
 * Returns YES, if at all objects in array are members of provided class.
 *
 * @param objectClass class of object
 * @return YES if array contains only objects of same class.
 */
- (BOOL)alpha_containsAllObjectsOfClass:(Class)objectClass;

/*!
 * Returns YES, if at all objects in array are of provided class or
 * have inherited from provided class.
 *
 * @param objectClass class of object
 * @return YES if array contains only objects of same or inherited class.
 */
- (BOOL)alpha_containsAllObjectsOfInheritedClass:(Class)objectClass;

@end
