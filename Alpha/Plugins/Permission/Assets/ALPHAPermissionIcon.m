//
//  ALPHAPermissionIcon.m
//  Alpha
//
//  Created by Dal Rupnik on 02/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAPermissionIcon.h"

NSString *const ALPHAIconPermissionIdentifier = @"com.unifiedsense.alpha.icon.permission";

@implementation ALPHAPermissionIcon

- (instancetype)init
{
    self = [super initWithIdentifier:ALPHAIconPermissionIdentifier];
    
    if (self)
    {
        self.drawingSize = CGSizeMake(80.0, 80.0);
        self.drawingBlock = ^(CGSize size, NSDictionary* parameters)
        {
            UIColor *fillColor = parameters[ALPHADrawingForegroundColorKey];
            
            CGRect frame = { CGPointZero, size };
            
            
        };
    }
    
    return self;
}


@end
