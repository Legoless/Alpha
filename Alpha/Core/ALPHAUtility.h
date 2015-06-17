//
//  ALPHAUtility.h
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

@import Foundation;

#define ALPHAFloor(x) (floor([[UIScreen mainScreen] scale] * (x)) / [[UIScreen mainScreen] scale])

@interface ALPHAUtility : NSObject

+ (UIInterfaceOrientationMask)infoPlistSupportedInterfaceOrientationsMask;

@end
