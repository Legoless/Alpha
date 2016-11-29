//
//  ALPHAMockObject.h
//  Alpha
//
//  Created by Dal Rupnik on 01/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;

/*!
 *  Mock Object will act as set object and it will redirect notifications to the object property (if set).
 *  
 *  To correctly use the mock object, one must override trackInvocation: method, to receive invocation details
 *  and do appropriate actions.
 */
@interface ALPHAMockObject : NSObject

/*!
 *  Object that is mocked, object will always receive the messages
 */
@property (nonatomic, strong) id object;

/*!
 *  Array of selectors that will always receive the invocation. If you want to track a selector, but original
 *  object does not respond to it (for example optional delegate methods), you can add it's selector into this
 *  array.
 */
@property (atomic, strong) NSArray *trackedSelectors;

/*!
 *  This method is called when mock object receives an invocation that either object responds to or it's selector
 *  is in trackedSelectors.
 *
 *  This method should be overriden by any appropriate subclass to add specific actions.
 *
 *  @param anInvocation invocation
 */
- (void)trackInvocation:(NSInvocation *)anInvocation;

@end
