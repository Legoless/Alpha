//
//  UIView+Snapshot.m
//  Alpha
//
//  Created by Dal Rupnik on 29/11/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

#import "UIView+Snapshot.h"

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)alpha_snapshotImage {
    return [self alpha_snapshotImageWithScale:2.0];
}

- (UIImage *)alpha_snapshotImageWithScale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions (self.bounds.size, NO, scale);
    
    //
    // Use iOS 7 fast method if possible
    //
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }
    else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
