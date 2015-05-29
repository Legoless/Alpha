//
//  FLEXAutoFillEngine.h
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

/*!
 *  I am a wizard!
 */
@interface FLEXAutoFillEngine : NSObject

+ (instancetype)sharedEngine;

- (void)autoFillView:(UIView *)view;

@end
