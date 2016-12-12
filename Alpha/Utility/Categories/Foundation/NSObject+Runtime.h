//
//  NSObject+Runtime.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "NSObject+Runtime.h"

@import Foundation;

@interface NSObject (Runtime)

+ (NSArray *)alpha_subclasses;

- (NSArray *)alpha_subclasses;

/**
 *  Returns array of Class that are hay_subclasses of class
 *
 *  @param parentClass subclasses
 *
 *  @return array of Class objects
 */
+ (NSArray *)alpha_subclassesOfClass:(Class)parentClass;

@end
