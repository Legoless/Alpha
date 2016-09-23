//
//  ALPHAView.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHARuntimeUtility.h"

#import "ALPHASerializableView.h"

@implementation ALPHASerializableView

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    
    if (self)
    {
        self.viewClass = NSStringFromClass([view class]);
        self.viewPointer = [NSString stringWithFormat:@"%p", view];
        self.viewDescription = [ALPHARuntimeUtility descriptionForView:view includingFrame:NO];
        
        NSInteger depth = 0;
        UIView *tryView = view;
        
        while (tryView.superview)
        {
            tryView = tryView.superview;
            depth++;
        }
        
        self.depth = depth;
        
        self.frame = NSStringFromCGRect(view.frame);
        self.bounds = NSStringFromCGRect(view.bounds);
        self.center = NSStringFromCGPoint(view.center);
        self.transform = NSStringFromCGAffineTransform(view.transform);
        self.backgroundColor = view.backgroundColor;
        
        self.alpha = view.alpha;
        self.opaque = view.opaque;
        self.hidden = view.hidden;
        self.clipsToBounds = view.clipsToBounds;
        self.userInteractionEnabled = view.userInteractionEnabled;
        
        self.gestureRecognizerCount = view.gestureRecognizers.count;
        
        if ([view respondsToSelector:@selector(textColor)])
        {
            self.textColor = [view performSelector:@selector(textColor)];
        }
        
        if ([view respondsToSelector:@selector(text)])
        {
            self.text = [view performSelector:@selector(text)];
        }
        
        if ([view respondsToSelector:@selector(font)])
        {
            self.font = [[view performSelector:@selector(font)] description];
        }
    }
    
    return self;
}

@end
