//
//  UIDevice+ALPHAStatus.h
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

/*!
 *  Requires VisualVoiceMail private framework to be linked with the target
 */
@interface UIDevice (ALPHAStatus)

//- (float)alpha_gsmSignalStrength;

/*!
 *  Will return current carrier name using VisualVoiceMail private API
 *
 *  @return string with current carrier name
 */
- (NSString *)alpha_carrierName;

@end
