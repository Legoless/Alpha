//
//  UIView+Snapshot.h
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)hay_snapshotImage
{
    return [self hay_snapshotImageWithScale:2.0];
}

- (UIImage *)hay_snapshotImageWithScale:(CGFloat)scale
{
	UIGraphicsBeginImageContextWithOptions (self.bounds.size, NO, scale);
    
    //
    // Use iOS 7 fast method if possible
    //
    
	if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
		[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
	}
	else
    {
		[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	}
    
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return image;
}

@end
