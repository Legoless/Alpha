//
//  FLEXTrigger.h
//  UICatalog
//
//  Created by Dal Rupnik on 05/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

@interface ALPHATrigger : NSObject

/*!
 *  When set to YES, trigger is automatically integrated into Alpha system
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/*!
 *  Executes trigger, opens FLEX explorer
 *
 *  @param sender Trigger sender
 */
- (void)trigger:(id)sender;

@end
