//
//  ALPHATrigger.h
//  Alpha
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright © 2014 Unified Sense. All rights reserved.
//

@import Foundation;

@interface ALPHATrigger : NSObject

/*!
 *  When set to YES, trigger is automatically integrated into Alpha system
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Executes trigger, opens Alpha
 *
 *  @param sender Trigger sender
 */
- (void)trigger:(id)sender;

@end
