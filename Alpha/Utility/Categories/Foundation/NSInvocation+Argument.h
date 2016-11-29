//
//  NSInvocation+Argument.h
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

@import Foundation;

@interface NSInvocation (Argument)

/*!
 *  Returns object in invocation at index
 *
 *  @param index of invocation object
 *
 *  @return object
 */
- (id)alpha_objectAtIndex:(NSInteger)index;

@end
