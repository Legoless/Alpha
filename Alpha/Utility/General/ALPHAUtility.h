//
//  ALPHAUtility.h
//  Alpha
//
//  Created by Dal Rupnik on 17/6/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import Foundation;
@import UIKit;

#define ALPHAFloor(x) (floor([[UIScreen mainScreen] scale] * (x)) / [[UIScreen mainScreen] scale])

#define ALPHAEncodeBool(expr) ( (expr) ? @"Yes" : @"No" )
#define ALPHAEncodeString(expr) ( (expr != nil) ? [expr description] : @"" )

@interface ALPHAUtility : NSObject

+ (UIInterfaceOrientationMask)infoPlistSupportedInterfaceOrientationsMask;

@end
