//
//  ALPHAEventPermission.h
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import EventKit;

#import "ALPHAPermission.h"

@interface ALPHAEventPermission : ALPHAPermission

/*!
 *  Entity type
 *
 *  @default: EKEntityTypeEvent
 */
@property (nonatomic, assign) EKEntityType entityType;

+ (ALPHAPermission *)reminderPermission;

@end
