//
//  ALPHAAppsListIcon.m
//  Alpha
//
//  Created by odnairy on 19/07/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAApplicationIcon.h"

NSString *const ALPHAIconAppsListIdentifier = @"com.odnairy.alpha.icon.application";

@implementation ALPHAApplicationIcon
- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconAppsListIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(20.0, 20.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            
            //// Rectangle Drawing
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1, 1, 18, 18) cornerRadius: 3];
            [UIColor.lightGrayColor setStroke];
            rectanglePath.lineWidth = 2;
            [rectanglePath stroke];
            
            
            //// Rectangle 2 Drawing
            UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(4.5, 4.5, 4, 4) byRoundingCorners: UIRectCornerTopLeft cornerRadii: CGSizeMake(1, 1)];
            [rectangle2Path closePath];
            [UIColor.lightGrayColor setStroke];
            rectangle2Path.lineWidth = 1;
            [rectangle2Path stroke];
            
            
            //// Rectangle 3 Drawing
            UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(11.5, 4.5, 4, 4) cornerRadius: 1];
            [UIColor.lightGrayColor setStroke];
            rectangle3Path.lineWidth = 1;
            [rectangle3Path stroke];
            
            
            //// Rectangle 4 Drawing
            UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect: CGRectMake(4.5, 11.5, 4, 4)];
            [UIColor.lightGrayColor setStroke];
            rectangle4Path.lineWidth = 1;
            [rectangle4Path stroke];
            
            
            //// Rectangle 5 Drawing
            UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(11.5, 11.5, 4, 4) byRoundingCorners: UIRectCornerBottomRight cornerRadii: CGSizeMake(1, 1)];
            [rectangle5Path closePath];
            [UIColor.lightGrayColor setStroke];
            rectangle5Path.lineWidth = 1;
            [rectangle5Path stroke];



        };
    }
    
    return self;
}

@end
