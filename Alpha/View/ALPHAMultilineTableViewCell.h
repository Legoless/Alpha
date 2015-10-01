//
//  ALPHAMultilineTableViewCell.h
//  Alpha
//
//  Created by Ryan Olson on 2/13/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import UIKit;

extern NSString *const kALPHAMultilineTableViewCellIdentifier;

@interface ALPHAMultilineTableViewCell : UITableViewCell

+ (CGFloat)preferredHeightWithAttributedText:(NSAttributedString *)attributedText inTableViewWidth:(CGFloat)tableViewWidth style:(UITableViewStyle)style showsAccessory:(BOOL)showsAccessory;

@end
