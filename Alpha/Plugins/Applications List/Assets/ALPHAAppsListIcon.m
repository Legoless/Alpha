//
//  ALPHAAppsListIcon.m
//  Alpha
//
//  Created by odnairy on 19/07/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAAppsListIcon.h"

NSString *const ALPHAIconAppsListIdentifier = @"com.odnairy.alpha.icon.applicationslist";

@implementation ALPHAAppsListIcon
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
            
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(3, 3, 14, 14)];
            [UIColor.lightGrayColor setStroke];
            ovalPath.lineWidth = 2;
            [ovalPath stroke];


        };
    }
    
    return self;
}

@end
