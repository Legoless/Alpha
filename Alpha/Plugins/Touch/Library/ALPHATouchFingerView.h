//
//  ALPHATouchFingerView.h
//  Alpha
//
//  Created by Dal Rupnik on 18/09/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

/*!
 *  Represents a single view on screen.
 */
@interface ALPHATouchFingerView : UIView

- (id)initWithPoint:(CGPoint)point;

- (void)updateWithTouch:(UITouch *)touch;

@end
